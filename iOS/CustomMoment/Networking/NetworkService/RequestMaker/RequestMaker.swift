//
//  RequestMaker.swift
//  CustomMoment
//
//  Created by Hoon on 2023/05/10.
//

/// RequestMaker : RequestMakable 구현한 구조체, request가 필요한 모든 네트워크 모듈은
/// 이 구조체를 인스턴스화 하여 내부에서 이용

import Foundation

public struct RequestMaker: RequestMakable {
    
    public init() {}
    
    public func makeRequest(url: URL,
                            method: HTTPMethod,
                            headers: [String : String],
                            body: Data?) -> URLRequest? {
        
        var request = URLRequest(url: url)
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = body
        
        switch method {
        case .get:
            return request
        case .post:
            request.httpMethod = method.rawValue
            return request
        case .patch:
            request.httpMethod = method.rawValue
            return request
        case .put:
            request.httpMethod = method.rawValue
            return request
        case .delete:
            request.httpMethod = method.rawValue
            return request
        }
    }

}