//
//  URLSessionTaskProtocol.swift
//  CustomMoment
//
//  Created by Hoon on 2023/05/08.
//

import Foundation

public protocol URLSessionTaskProtocol {
    
    var state: URLSessionTask.State { get }
    
    func resume()
    func cancel()
}
