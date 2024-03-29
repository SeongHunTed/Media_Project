//
//  ResponseParser.swift
//  CustomMoment
//
//  Created by Hoon on 2023/05/08.
//

import Foundation

public protocol ResponseParser {
    
    func parseResponse(response: URLResponseProtocol?, mimeType: MimeType) -> URLResponseProtocol
    
    func extractDecodedJsonData<T: Codable>(decodeType: T.Type,
                                              binaryData: Data?) -> T?
    
    func extractEncodedJsonData<T: Codable>(data: T) -> Data?
}
