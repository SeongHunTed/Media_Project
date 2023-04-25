//
//  AuthModel.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/14.
//

import Foundation

struct SignUpRequest: Codable {
    let email: String
    let name: String
    let password: String
    let digit: String
    let birth: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case digit
        case birth
        case password
        case address
    }
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String
    let isSeller: Bool
    
    enum CodingKeys: String, CodingKey {
        case token
        case isSeller = "is_seller"
    }
}


struct MyInfoResponse: Codable {
    let id: Int
    let email: String
    let name: String
    let digit: String
    let birth: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case digit
        case birth
        case address
    }
}
