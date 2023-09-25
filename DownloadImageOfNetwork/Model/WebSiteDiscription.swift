//
//  WebSiteDiscription.swift
//  DownloadImageOfNetwork
//
//  Created by petar on 19.09.2023.
//

import Foundation


struct WebSiteDescription: Decodable{
    
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]
}
