//
//  APIClient.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/14.
//

import Foundation


class APIClient {
    
    static let shared = APIClient()
    
    private init() {}
    
    let baseURL = "http://custommoment.link/"
    
    // MARK: - Reuse Variables
    
    var authToken: String?
    var isSeller: Bool?
    
    //MARK: - AUTH
    class Auth {
        
        func signUp(_ signUpRequest: SignUpRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "accounts/signup") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(signUpRequest)
                request.httpBody = jsonData
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
            task.resume()
        }
        
        func login(_ loginRequest: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "accounts/login") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(loginRequest)
                request.httpBody = jsonData
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(loginResponse))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    let auth = Auth()
}
