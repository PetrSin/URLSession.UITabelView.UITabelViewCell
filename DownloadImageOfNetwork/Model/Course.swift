//
//  Course.swift
//  DownloadImageOfNetwork
//
//  Created by petar on 19.09.2023.
//

import Foundation

//обязательно подписываем модель под протокол декодебл
//для вложенных структур необходимо делать вложенные структуры 
struct Course: Decodable{
    
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    let numberOfLessons: Int?
    let numberOfTests: Int?
    
    
}
