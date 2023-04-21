//
//  CakeOptionModel.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/19.
//

import Foundation

struct CakeOptionRequest: Codable {
    let cakeName: String
    let storeName: String
    
    enum CodingKeys: String, CodingKey {
        case cakeName = "cake_name"
        case storeName = "store_name"
    }
}

struct CakeOptionResponse: Codable {
    let name: String
    let store: Int
    let price: Int
    let size: [Option]?
    let flavor: [Option]?
    let color: [Option]?
    let design: [Option]?
    let side_deco: [Option]?
    let deco: [Option]?
    let lettering: [Option]?
    let font: [Option]?
    let picture: [Option]?
    let package: [Option]?
    let candle: [Option]?
    let image: [CakeImage]?
}

//struct Option: Codable {
//    let optionName: String
//    let price: Int
//
//    private enum CodingKeys: String, CodingKey {
//        case size, flavor, color, design, side_deco, deco, lettering, font, picture, package, candle
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let codingPath = decoder.codingPath
//        guard let optionKey = codingPath.first?.stringValue,
//              let optionCodingKey = CodingKeys(rawValue: optionKey) else {
//            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Unable to decode option name"))
//        }
//        optionName = try container.decode(String.self, forKey: optionCodingKey)
//        if let priceKey = CodingKeys(rawValue: "\(optionKey)_price") {
//            price = try container.decodeIfPresent(Int.self, forKey: priceKey) ?? 0
//        } else {
//            price = 0
//        }
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(optionName, forKey: CodingKeys(rawValue: optionName)!)
//        if let priceKey = CodingKeys(rawValue: "\(optionName)_price") {
//            try container.encode(price, forKey: priceKey)
//        }
//    }
//}

struct Option: Codable {
    let optionName: String
    let price: Int

    private enum CodingKeys: CodingKey {
        case size, flavor, color, design, side_deco, deco, lettering, font, picture, package, candle
        case price
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        price = try container.decode(Int.self, forKey: .price)

        let codingPath = decoder.codingPath
        guard let optionKey = codingPath.first?.stringValue,
              let optionCodingKey = CodingKeys(stringValue: optionKey) else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Unable to decode option name"))
        }
        optionName = try container.decode(String.self, forKey: optionCodingKey)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(price, forKey: .price)
    }
}

struct CakeImage: Codable {
    let image: String
}

