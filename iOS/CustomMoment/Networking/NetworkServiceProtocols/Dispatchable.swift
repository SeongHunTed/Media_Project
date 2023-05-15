//
//  Dispatchable.swift
//  CustomMoment
//
//  Created by Hoon on 2023/05/08.
//

/// Dispatchable은 baseURL, session을 기반으로 dispatch() 메서드를 실행하여 실제 네트워킹을
/// 실행할 수 있도록 하는 프로토콜

import Foundation

// 나중에 NetworkModel에서 통합
//public enum Result<Value> {
//    case failure(Error)
//    case success(Value)
//}

public protocol Dispatchable {
    
    var session: URLSessionProtocol { get }
    
    func dispatch(request: URLRequest,
                  completion: @escaping (Result<Data>, URLResponseProtocol?) -> ())
}
