//
//  MainCakeInfoModel.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/17.
//

import Foundation

struct MainCakeInfoRequest: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "cake_name"
    }
}

struct MainCakeInfoResponse: Codable {
    let name: String
    let storeName: String
    let price: Int
    let infoImage: [CakeInfoImage]
    let images: [MainCakeImage]
    
    enum CodingKeys: String, CodingKey {
        case images = "image"
        case infoImage = "info_image"
        case storeName = "store_name"
        case name
        case price
    }
}

struct CakeInfoImage: Codable {
    let infoImageURL: String

    enum CodingKeys: String, CodingKey {
        case infoImageURL = "info_image"
    }

    var fullInfoImageURL: String {
        return MEDIA_URL + infoImageURL
    }
}
