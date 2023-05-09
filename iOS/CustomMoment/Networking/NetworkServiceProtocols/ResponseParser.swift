//
//  ResponseParser.swift
//  CustomMoment
//
//  Created by Hoon on 2023/05/08.
//

import Foundation

public protocol ResponseParser {
    
    func parseResponse(response: URLResponseProtocol?) -> URLResponseProtocol
    
    func extractDecodedJsonData<T: Decodable>(decideType: T.Type,
                                              binaryData: Data?) -> T?
    
    func extractEncodedJsonData<T: Encodable>(data: T) -> Data?
}
