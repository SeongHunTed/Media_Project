//
//  MainCakeModel.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/17.
//

import Foundation

let MEDIA_URL = "http://43.200.163.99/media/"

struct MainCakeRequest: Codable {
    let name: String
    let price: Int
    let storeName: String
    let images: [MainCakeImage]
    
    var mainImage: MainCakeImage? {
        return images.first
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case storeName = "store_name"
        case images = "image"
    }
}


struct MainCakeImage: Codable {
    let imageURL: String
    
    var fullImageURL: String {
        return MEDIA_URL + imageURL
    }
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image"
    }
}
