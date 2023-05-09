//
//  URLResponseProtocol.swift
//  CustomMoment
//
//  Created by Hoon on 2023/05/08.
//

import Foundation

public protocol URLResponseProtocol {
    var isSuccess: Bool { get }
    var url: URL? { get }
}

extension URLResponse {
    
    public var isSuccess: Bool {
        guard let response = self as? HTTPURLResponse else { return false }
        return (200...299).contains(response.statusCode)
    }
}
