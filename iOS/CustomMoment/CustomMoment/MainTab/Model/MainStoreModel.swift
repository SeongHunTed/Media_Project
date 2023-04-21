//
//  MainStoreModel.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/17.
//

import Foundation

struct MainStoreRequest: Codable {
    let name: String
    let intro: String
    let address: String
    let image1: String
    
    enum CodingKeys: String, CodingKey {
        case name = "store_name"
        case intro = "store_intro"
        case address = "store_address"
        case image1
    }
    
    var fullImageURL: String {
        return MEDIA_URL + image1
    }
}


struct MainStorePopUpRequest: Codable {
    let storeName: String
    let storeIntro: String
    let storeOpenTime: String
    let storeCloseTime: String
    let storeDigit: String
    let storeAddress: String
    let image1: String
    let image2: String
    let image3: String
    let image4: String
    let image5: String
    
    enum CodingKeys: String, CodingKey {
        case image1
        case image2
        case image3
        case image4
        case image5
        case storeName = "store_name"
        case storeIntro = "store_intro"
        case storeOpenTime = "store_opentime"
        case storeCloseTime = "store_closetime"
        case storeDigit = "store_digit"
        case storeAddress = "store_address"
    }
    
    var imageURLs: [String] {
        return [image1, image2, image3, image4, image5]
    }
    
    var fullImageURLs: [String] {
        return imageURLs.map { MEDIA_URL + $0 }
    }

}
