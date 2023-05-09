//
//  RequestMakable.swift
//  CustomMoment
//
//  Created by Hoon on 2023/05/08.
//

/// RequestMakable은 HTTP 메서드, 파라미터, 헤더,  URL을 조합해 Request하게하는 프로토콜

import Foundation

public protocol RequestMakable {
    
    func makeRequest(url: URL?, method: HTTPMethod, header: [String: String],
                     body: Data?) -> URLRequest?
}
