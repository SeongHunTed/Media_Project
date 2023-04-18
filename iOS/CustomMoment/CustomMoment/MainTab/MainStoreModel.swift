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
