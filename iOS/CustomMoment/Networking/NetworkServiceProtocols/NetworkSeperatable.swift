//
//  NetworkSeperatable.swift
//  CustomMoment
//
//  Created by Hoon on 2023/05/08.
//

/// NetworkSeperatable은 다양한 HTTPMethod를 3개의 메서드로 추상화 하여 구분하는 프로토콜
/// 아마도 나한테는 필요 없을 메서드
/// firebase를 쓴다면 필요할듯
import Foundation

public protocol NetworkSeperatable {
    
    func read(path: String,
              headers: [String: String],
              queries: [URLQueryItem]?,
              completion: @escaping (Result<Data>, URLResponseProtocol?) -> Void)
    
    func write(path: String, data: Data, method: HTTPMethod,
               headers: [String: String],
               completion: @escaping (Result<Data>, URLResponseProtocol?) -> Void)
    
    func delete(path: String, completion: @escaping (Result<URLResponseProtocol?>) -> Void)
}
