//
//  JsonParser.swift
//  CustomMoment
//
//  Created by Hoon on 2023/05/10.
//

import Foundation

// 해당 부분은 나중에 좀더 고민해봐야할 것 같음
public enum MimeType: String {
    case json = "application/json"
}

public struct JsonParser: ResponseParser {
    
    public init() {}
    
    public func parseResponse(response: URLResponseProtocol?,
                              mimeType: MimeType) -> URLResponseProtocol {
        guard let response = response, response.isSuccess,
              response.isMimeType(type: mimeType) else {
            assertionFailure("response parsing failed")
            return URLResponse.init()
        }
        return response
    }
    
    public func extractDecodedJsonData<T>(decodeType: T.Type, binaryData: Data?) -> T? where T : Codable {
        guard let data = binaryData else { return nil }
        do {
            let decodeData = try JSONDecoder().decode(decodeType, from: data)
            return decodeData
        } catch(_) {
            return nil
        }
    }
    
    public func extractEncodedJsonData<T>(data: T) -> Data? where T : Codable {
        do {
            let encodeData = try JSONEncoder().encode(data)
            return encodeData
        } catch(let error) {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
