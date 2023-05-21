//
//  File.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/07.
//

import Foundation
import OpenAIKit
import UIKit

final class DalleAPIService: ObservableObject {
    
    private struct Reponse: Decodable {
        let data: [ImageURL]
    }
    
    struct ImageURL: Decodable {
        let url: String
    }
    
    enum APIError: Error {
        case unableToCreateImageURL
        case unableToConvertDataIntoImage
    }
    
//    let apiKey = Bundle.main.object(forInfoDictionaryKey: "OPENAI_API_KEY") as! String
    let apiKey = "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"
    
    func fetchImageForPrompt(_ prompt: String) async throws -> UIImage {
        let fetchImageURL = "https://api.openai.com/v1/images/generations"
        let urlRequest = try createURLRequestFor(httpMethod: "POST", url: fetchImageURL, prompt: prompt)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        let results = try decoder.decode(Reponse.self, from: data)
        
        let imageURL = results.data[0].url
        guard let imageURL = URL(string: imageURL) else {
            throw APIError.unableToConvertDataIntoImage
        }
        
        let (imageData, _) = try await URLSession.shared.data(from: imageURL)
        
        guard let image = UIImage(data: imageData) else {
            throw APIError.unableToConvertDataIntoImage
        }
        
        return image
    }
    
    private func createURLRequestFor(httpMethod: String, url: String, prompt: String) throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw APIError.unableToCreateImageURL
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonBody: [String: Any] = [
            "prompt" : "\(prompt)",
            "n" : 1,
            "size" : "512x512"
        ]
        
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: jsonBody)
        
        return urlRequest
    }
    
    func imageTransFetch(_ image: UIImage, completion: @escaping(Result<UIImage>) -> Void) {
        
        guard let url = URL(string: "https://master-white-box-cartoonization-psi1104.endpoint.ainize.ai/predict") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        var body = Data()

        // 필드 데이터를 추가합니다.
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file_type\"\r\n\r\n".data(using: .utf8)!)
        body.append("image".data(using: .utf8)!)
        body.append("\r\n".data(using: .utf8)!)

        // 파일 데이터를 추가합니다.
        
        let imageData = image.jpegData(compressionQuality: 1.0)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"source\"\r\n\r\n".data(using: .utf8)!)
        body.append(imageData!) // 이미지 데이터
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

    }
}



class NaverTranslator {
    
    let clientId: String
    let clientSecret: String
    
    init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
    
    func translate(source: String, target: String, text: String) async throws -> String {
        let urlString = "https://openapi.naver.com/v1/papago/n2mt"
        
        let params = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue(clientId, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        request.httpBody = params.percentEncoded()
        
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw NSError(domain: "Invalid response", code: 0, userInfo: nil)
        }
        
        if let translatedText = try? JSONDecoder().decode(TranslatedText.self, from: data) {
            return translatedText.message.result.translatedText
        } else {
            throw NSError(domain: "Failed to parse response data", code: 0, userInfo: nil)
        }
    }

    
    private struct TranslatedText: Codable {
        let message: Message
    }
    
    private struct Message: Codable {
        let result: TranslateResult
    }
    
    private struct TranslateResult: Codable {
        let translatedText: String
        
        enum CodingKeys: String, CodingKey {
            case translatedText = "translatedText"
        }
    }
    
}

private extension Dictionary where Key == String, Value == String {
    
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

private extension CharacterSet {
    
    static let urlQueryValueAllowed: CharacterSet = {
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "+&")
        return allowed
    }()
}
