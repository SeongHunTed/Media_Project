//
//  CalendarModel.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/20.
//

import Foundation

struct Group: Codable {
    let groupNum: Int
    let groupMaxOrder: Int
    let groupOrdered: Int
    let time: [Time]
    
    private enum CodingKeys: String, CodingKey {
        case groupNum = "group_num"
        case groupMaxOrder = "group_max_order"
        case groupOrdered = "group_ordered"
        case time
    }
    
}

struct Time: Codable {
    let pickupTime: String
    let timeMaxOrder: Int
    let timeOrdered: Int
    
    private enum CodingKeys: String, CodingKey {
        case pickupTime = "pickup_time"
        case timeMaxOrder = "time_max_order"
        case timeOrdered = "time_ordered"
    }
    
    var isAvailable: Bool {
        return timeMaxOrder - timeOrdered > 0
    }
}

struct TimeInfoResponse: Codable {
    let date: String
    let deadline: Int
    let closed: Bool
    let maxOrder: Int
    let storeName: String
    let group: [Group]
    
    private enum CodingKeys: String, CodingKey {
        case date, deadline, closed
        case maxOrder = "max_order"
        case storeName = "store_name"
        case group
    }
}

struct TimeInfoRequest: Codable {
    let storeName: String
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case storeName = "store_name"
        case date
    }
}


struct CalendarResponse: Codable {
    let date: String
    let closed: Bool
}
