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
    
    class Cake {
        func fetchCakeTapCake(_ page: Int, completion: @escaping (Result<[MainCakeRequest], Error>) -> Void) {
            guard let url = URL(string: APIClient.shared.baseURL + "cakes/cake-tap/\(page)") else { return }
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
        
        func fetchCakeOption(_ cakeOptionRequest: CakeOptionRequest, completion: @escaping (Result<CakeOptionResponse , Error>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "cakes/order") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(cakeOptionRequest)
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
                    let cakeOptionResponse = try decoder.decode(CakeOptionResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(cakeOptionResponse))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
        
        func fetchTime(_ orderRequest: TimeInfoRequest, completion: @escaping (Result<TimeInfoResponse , Error>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "calenders/order") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(orderRequest)
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
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                    }
                    return
                }
                
                if httpResponse.statusCode == 204 {
                    DispatchQueue.main.async {
                        completion(.failure(NSError(domain: "", code: 204, userInfo: ["message" : "204"])))
                    }
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let orderResponse = try decoder.decode(TimeInfoResponse.self, from: data)
                    print(orderResponse)
                    DispatchQueue.main.async {
                        completion(.success(orderResponse))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
        
        func fetchCalendar(_ storeName: String, completion: @escaping (Result<[CalendarResponse], Error>) -> Void) {
            guard let url = URL(string: APIClient.shared.baseURL + "calenders/calender/?store_name=\(storeName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
                return }
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
                    let calendar = try decoder.decode([CalendarResponse].self, from: data)
                    completion(.success(calendar))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    class Order {
        
        func registerCart(_ order: OrderRequest, completion: @escaping (Result<String, Error>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "orders/cart") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let token = APIClient.shared.authToken else {
                completion(.failure(NSError(domain: "Authorization", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token is missing"])))
                return
            }
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(order)
                request.httpBody = jsonData
            } catch {
                completion(.failure(error))
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                // 응답 처리
                if let _ = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                    completion(.success("Order registered successfully"))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
            }
            task.resume()
        }
        
        func requestOrder(_ order: OrderRequest, completion: @escaping (Result<String, Error>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "orders/order") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let token = APIClient.shared.authToken else {
                completion(.failure(NSError(domain: "Authorization", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token is missing"])))
                return
            }
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(order)
                request.httpBody = jsonData
            } catch {
                completion(.failure(error))
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                // 응답 처리
                if let _ = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                    completion(.success("Order registered successfully"))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
            }
            task.resume()
        }
        
        func fetchCart(completion: @escaping (Result<[CartResponse], Error>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "orders/cart") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let token = APIClient.shared.authToken else {
                completion(.failure(NSError(domain: "Authorization", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token is missing"])))
                return
            }
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
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
                print(String(data: data, encoding: .utf8) ?? "")
                do {
                    let decoder = JSONDecoder()
                    let cart = try decoder.decode([CartResponse].self, from: data)
                    completion(.success(cart))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchOrder(completion: @escaping (Result<[OrderResponse], Error>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "orders/order") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let token = APIClient.shared.authToken else {
                completion(.failure(NSError(domain: "Authorization", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token is missing"])))
                return
            }
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                    let order = try decoder.decode([OrderResponse].self, from: data)
                    completion(.success(order))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    let auth = Auth()
    let main = Main()
    let cake = Cake()
    let order = Order()
}
