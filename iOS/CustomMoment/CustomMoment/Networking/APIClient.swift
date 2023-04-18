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
    
//    let baseURL = "http://custommoment.link/"
    let baseURL = "http://43.200.163.99/"
    
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
    
    class Main {
        func fetchMainCake(completion: @escaping (Result<[MainCakeRequest], Error>) -> Void) {
            guard let url = URL(string: APIClient.shared.baseURL + "cakes") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
        
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "API", code: -1, userInfo: [NSLocalizedDescriptionKey : "No Data Received"])))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let cakes = try decoder.decode([MainCakeRequest].self, from: data)
                    completion(.success(cakes))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchMainStore(completion: @escaping (Result<[MainStoreRequest], Error>)->Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "stores") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "API", code: -1, userInfo: [NSLocalizedDescriptionKey : "No Data Received"])))
                    return
                }
                
                
                do {
                    let decoder = JSONDecoder()
                    let stores = try decoder.decode([MainStoreRequest].self, from: data)
                    completion(.success(stores))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchCakeInfo(_ targetCake: String, completion: @escaping (Result<MainCakeInfoResponse, Error>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "cakes/cake-popup/?cake_name=\(targetCake.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "API", code: -1, userInfo: [NSLocalizedDescriptionKey : "No Data Received"])))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let info = try decoder.decode(MainCakeInfoResponse.self, from: data)
                    completion(.success(info))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchStoreInfo(_ targetStore: String, completion: @escaping (Result<MainStorePopUpRequest, Error>)->Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "stores/detail/?store_name=\(targetStore.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "API", code: -1, userInfo: [NSLocalizedDescriptionKey : "No Data Received"])))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let store = try decoder.decode(MainStorePopUpRequest.self, from: data)
                    completion(.success(store))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    let auth = Auth()
    let main = Main()
}
