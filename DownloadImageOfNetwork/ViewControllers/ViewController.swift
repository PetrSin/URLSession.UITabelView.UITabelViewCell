//
//  ViewController.swift
//  DownloadImageOfNetwork
//
//  Created by petar on 18.09.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let downloadImageButton: UIButton = {
        var view = UIButton(type: .system)
        view.backgroundColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        view.setTitle("Press to Download Image", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        view.addTarget(self, action: #selector(downloadImage), for: .touchUpInside)
        view.layer.cornerRadius = 30
        return view
    }()
    
    let getButton: UIButton = {
        var view = UIButton(type: .system)
        view.backgroundColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        view.setTitle("GET", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        view.layer.cornerRadius = 30
        view.addTarget(self, action: #selector(getAction), for: .touchUpInside)
        return view
    }()
    
    let postButton: UIButton = {
        var view = UIButton(type: .system)
        view.backgroundColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        view.setTitle("POST", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        view.layer.cornerRadius = 30
        view.addTarget(self, action: #selector(postAction), for: .touchUpInside)
        return view
    }()
    
    let ourCoursesButton: UIButton = {
        var view = UIButton(type: .system)
        view.backgroundColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        view.setTitle("Our Course", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        view.layer.cornerRadius = 30
        view.addTarget(self, action: #selector(showCoursesPage), for: .touchUpInside)
        return view
    }()
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigBar()
        createAllUIConstains()
    }
    
    private func createNavigBar(){
        navigationItem.title = "Controls"
        navigationController?.navigationBar.backgroundColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
    }
    
    private func createAllUIConstains(){
        view.addSubview(downloadImageButton)
        view.addSubview(getButton)
        view.addSubview(postButton)
        view.addSubview(ourCoursesButton)
        
        downloadImageButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.bounds.height / 5)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(100)
        }
        
        getButton.snp.makeConstraints { make in
            make.top.equalTo(downloadImageButton).inset(150)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(100)
        }
        
        postButton.snp.makeConstraints { make in
            make.top.equalTo(getButton).inset(150)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(100)
        }
        
        ourCoursesButton.snp.makeConstraints { make in
            make.top.equalTo(postButton).inset(150)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(100)
            
        }
        
    }
    
    @objc func downloadImage(){
        navigationController?.pushViewController(DownloadImageController(), animated: true)
    }
    
    @objc func showCoursesPage(){
        navigationController?.pushViewController(CoursesPageViewController(), animated: true)
    }
    
    @objc func getAction(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let session = URLSession.shared
      
        //data - данные с сервера
        //response - ответ с сервера
        //error - ошибки в процессе
        session.dataTask(with: url) { data, response, error in
            guard
                let data = data
            else { return }
            print(data)
            
            //переобразование данных получаемых с сервера
            do{
                let json = try JSONSerialization.jsonObject(with: data)  //преобразовываем json из данных в data
                print(json)
            }catch{
                print(error)   //в случае ошибки выводим ошибку 
            }
            
        }.resume()      //важно необходимо инициализировать сессию
    }
    
    @objc func postAction(){
        //проверяем url
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        //в отличии от get запроса в post запросе необходимо передать данные
        //создаем словарь с даннвми которые будут переданны на сервер
        let userData = ["Coure": "Networking", "Leeson": "Get and Post requests"] //слварь с двнными которые можно поместить в тело запроса
        var request = URLRequest(url: url)  //создаем экземпляр класса URLRequest где в инициализацию передаю ссыллку провереннную в начале метода
        request.httpMethod = "POST"  //пережде чем сделать запрос, необходимо указать его метод
        
        //прежде чем отправить пользовательские данные на сервер их необходимо преобразовать в json формат
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData) else { return } //преобразовываю словарь в json формат при помощи JSONSerialization( try - на случай ошибки)( через гвард тк на выходе опционал)
        
        //после преобразования данных необзодимо поместить их в тело запроса
        request.httpBody = httpBody
        //добавляю в запрос необходимые параметры
        //(значение, то для какого заголока вводятся эти параметры)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //теперь необходимо создать сессию для отправки данных на сервер
        //создаю экземпляр класса urlsession
        let session = URLSession.shared
        //создаем дататаск но с инициализатором URLrequest
        //передаем ему созданный ранее request
        session.dataTask(with: request) { data, response, error in
            //проверяем полученные данные
            guard let data = data, let response = response else { return }
            print(response)  //вывожу в консоль ответ сервера
            //<NSHTTPURLResponse: 0x6000002da200> { URL: https://jsonplaceholder.typicode.com/posts } { Status Code: 201, Headers }
            //статус код 201 - созданно, сл запись на сервер добавленнна
            
            //преобразую данные с сервера и в случаее ошибки - отлавливаю
            do{
                let json = try JSONSerialization.jsonObject(with: data)//преаращаю данные с сервера в json
                print(json)
            }catch{
                print(error)   //в случае ошибки выывожу ошибку
            }
        }.resume()  //запускаю сессию
        
        
        
    }

}


