//
//  OrderModel.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/22.
//

import Foundation

struct OrderRequest: Codable {
    let storeName: String
    let cakeName: String
    let cakePrice: Int
    let pickupDate: String
    let pickupTime: String
    let option: String

    enum CodingKeys: String, CodingKey {
        case storeName = "store_name"
        case cakeName = "cake_name"
        case cakePrice = "cake_price"
        case pickupDate = "pickup_date"
        case pickupTime = "pickup_time"
        case option = "option"
    }
}


struct OrderResponse: Codable {
    let id: String
    let storeName: String
    let cakeName: String
    let cakeImage: String
    let orderedAt: String
    let option: String
    let pickUpDate: String
    let pickUpTime: String
    let status: String
    let price: Int
    
    var fullImageURL: String {
        return MEDIA_URL + cakeImage
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case option
        case status
        case price
        case storeName = "store_name"
        case cakeName = "cake_name"
        case cakeImage = "cake_image"
        case orderedAt = "ordered_at"
        case pickUpDate = "pickup_date"
        case pickUpTime = "pickup_time"
    }
}

struct CartResponse: Codable {
    let storeName: String
    let cakeName: String
    let cakeImage: String
    let option: String
    let pickUpDate: String
    let pickUpTime: String
    let price: Int
    
    var fullImageURL: String {
        return MEDIA_URL + cakeImage
    }
    
    enum CodingKeys: String, CodingKey {
        case storeName = "store_name"
        case cakeName = "cake_name"
        case cakeImage = "cake_image"
        case pickUpDate = "pickup_date"
        case pickUpTime = "pickup_time"
        case option
        case price
    }
}
