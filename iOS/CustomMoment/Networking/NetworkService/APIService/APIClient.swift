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
        
        let requestMaker = RequestMaker()
        var jsonParser = JsonParser()
        let dispatcher = Dispatcher(session: URLSession.shared)
        
        func signUp(_ signUpRequest: SignUpRequest,
                    completion: @escaping (Result<Data>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "accounts/signup") else { return }
            
            let jsonData = jsonParser.extractEncodedJsonData(data: signUpRequest)
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .post,
                                                         headers: ["Content-Type": "application/json"],
                                                         body: jsonData) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    completion(.success(data))
                }
            }
        }
        
        func login(_ loginRequest: LoginRequest,
                   completion: @escaping (Result<LoginResponse>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "accounts/login") else { return }
            
            let jsonData = jsonParser.extractEncodedJsonData(data: loginRequest)
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .post,
                                                         headers: ["Content-Type": "application/json"],
                                                         body: jsonData) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: LoginResponse.self, binaryData: data) else {
                        completion(.failure(APIError.jsonParsingFailure))
                        return
                    }
                    completion(.success(responseData))
                }
            }
        }
        
        func fetchInfo(completion: @escaping (Result<MyInfoResponse>) -> Void) {
            guard let url = URL(string: APIClient.shared.baseURL + "accounts/info") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let token = APIClient.shared.authToken else {
                completion(.failure(NSError(domain: "Authorization", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token is missing"])))
                return
            }
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
            
//            guard let token = APIClient.shared.authToken else {
//                completion(.failure(AuthError.tokenError))
//                return
//            }
//
//            guard let request = requestMaker.makeRequest(url: url,
//                                                         method: .get,
//                                                         headers: ["Content-Type" : "application/json", "Token \(token)" : "Authorization"], body: nil) else {
//                completion(.failure(APIError.requestFailed))
//                return
//            }
            
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: MyInfoResponse.self, binaryData: data) else {
                        completion(.failure(APIError.jsonParsingFailure))
                        return
                    }
                    completion(.success(responseData))

                }
            }
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//                if let error = error {
//                    DispatchQueue.main.async {
//                        completion(.failure(error))
//                    }
//                    return
//                }
//
//                guard let data = data else {
//                    completion(.failure(NSError(domain: "API", code: -1, userInfo: [NSLocalizedDescriptionKey : "No Data Received"])))
//                    return
//                }
//
//                do {
//                    let decoder = JSONDecoder()
//                    let info = try decoder.decode(MyInfoResponse.self, from: data)
//                    completion(.success(info))
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//            task.resume()
            
        }
        
    }
    
    class Main {
        
        let requestMaker = RequestMaker()
        var jsonParser = JsonParser()
        let dispatcher = Dispatcher(session: URLSession.shared)
        
        func fetchMainCake(completion: @escaping (Result<[MainCakeRequest]>) -> Void) {
            guard let url = URL(string: APIClient.shared.baseURL + "cakes") else { return }
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .get,
                                                         headers: [:],
                                                         body: nil) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
        
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: [MainCakeRequest].self, binaryData: data) else {
                        completion(.failure(APIError.jsonParsingFailure))
                        return
                    }
                    completion(.success(responseData))
                }
            }
        }
        
        func fetchMainStore(completion: @escaping (Result<[MainStoreRequest]>)->Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "stores") else { return }
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .get,
                                                         headers: [:],
                                                         body: nil) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: [MainStoreRequest].self, binaryData: data) else {
                        completion(.failure(APIError.jsonParsingFailure))
                        return
                    }
                    completion(.success(responseData))
                }
            }
        }
        
        func fetchCakeInfo(_ targetCake: String, completion: @escaping (Result<MainCakeInfoResponse>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "cakes/cake-popup/?cake_name=\(targetCake.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else { return }
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .get,
                                                         headers: ["Content-Type": "application/json"],
                                                         body: nil) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: MainCakeInfoResponse.self, binaryData: data) else {
                        completion(.failure(APIError.jsonParsingFailure))
                        return
                    }
                    completion(.success(responseData))
                }
            }
        }
        
        func fetchStoreInfo(_ targetStore: String, completion: @escaping (Result<MainStorePopUpRequest>)->Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "stores/detail/?store_name=\(targetStore.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else { return }
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .get,
                                                         headers: ["Content-Type": "application/json"],
                                                         body: nil) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: MainStorePopUpRequest.self, binaryData: data) else {
                        completion(.failure(APIError.jsonParsingFailure))
                        return
                    }
                    completion(.success(responseData))
                }
            }
        }
    }
    
    class Cake {
        
        let requestMaker = RequestMaker()
        var jsonParser = JsonParser()
        let dispatcher = Dispatcher(session: URLSession.shared)
        
        func fetchCakeTapCake(_ page: Int, completion: @escaping (Result<[MainCakeRequest]>) -> Void) {
            guard let url = URL(string: APIClient.shared.baseURL + "cakes/cake-tap/\(page)") else { return }
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .get,
                                                         headers: ["Content-Type": "application/json"],
                                                         body: nil) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: [MainCakeRequest].self, binaryData: data) else {
                        completion(.failure(APIError.jsonParsingFailure))
                        return
                    }
                    completion(.success(responseData))
                }
            }
        }
        
        func fetchFilterCake(_ page: Int, completion: @escaping (Result<[MainCakeRequest]>) -> Void) {
            guard let url = URL(string: APIClient.shared.baseURL + "cakes/cake-filter/\(page)") else { return }
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .get,
                                                         headers: ["Content-Type": "application/json"],
                                                         body: nil) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: [MainCakeRequest].self, binaryData: data) else {
                        completion(.failure(APIError.jsonParsingFailure))
                        return
                    }
                    completion(.success(responseData))
                }
            }
        }
        
        func fetchCakePerStore(_ targetStore: String, completion: @escaping (Result<[MainCakeRequest]>) -> Void) {
            guard let url = URL(string: APIClient.shared.baseURL + "cakes/cake-per-store/?store_name=\(targetStore.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else { return }
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .get,
                                                         headers: ["Content-Type": "application/json"],
                                                         body: nil) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: [MainCakeRequest].self, binaryData: data) else {
                        completion(.failure(APIError.jsonParsingFailure))
                        return
                    }
                    completion(.success(responseData))
                }
            }
        }
        
        func fetchCakeOption(_ cakeOptionRequest: CakeOptionRequest, completion: @escaping (Result<CakeOptionResponse>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "cakes/order") else { return }
            
            let jsonData = jsonParser.extractEncodedJsonData(data: cakeOptionRequest)
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .post,
                                                         headers: ["Content-Type": "application/json"],
                                                         body: jsonData) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: CakeOptionResponse.self, binaryData: data) else {
                        completion(.failure(APIError.jsonParsingFailure))
                        return
                    }
                    completion(.success(responseData))
                }
            }
        }
        
        func fetchTime(_ orderRequest: TimeInfoRequest, completion: @escaping (Result<TimeInfoResponse>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "calenders/order") else { return }
            
            let jsonData = jsonParser.extractEncodedJsonData(data: orderRequest)
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .post,
                                                         headers: ["Content-Type": "application/json"],
                                                         body: jsonData) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
//            dispatcher.dispatch(request: request) { (result, response) in
//                switch result {
//                case .failure(let error):
//                    completion(.failure(error))
//                case .success(let data):
//                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: TimeInfoResponse.self, binaryData: data) else {
//                        completion(.failure(APIError.jsonParsingFailure))
//                        return
//                    }
//                    completion(.success(responseData))
//                }
//            }
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
        
        func fetchCalendar(_ storeName: String, completion: @escaping (Result<[CalendarResponse]>) -> Void) {
            guard let url = URL(string: APIClient.shared.baseURL + "calenders/calender/?store_name=\(storeName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
                return }
            
            guard let request = requestMaker.makeRequest(url: url,
                                                         method: .get,
                                                         headers: ["Content-Type": "application/json"],
                                                         body: nil) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            dispatcher.dispatch(request: request) { (result, response) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: [CalendarResponse].self, binaryData: data) else {
                        completion(.failure(APIError.jsonParsingFailure))
                        return
                    }
                    completion(.success(responseData))
                }
            }
        }
    }
    
    class Order {
        
        let requestMaker = RequestMaker()
        var jsonParser = JsonParser()
        let dispatcher = Dispatcher(session: URLSession.shared)
        
        func registerCart(_ orderRequest: OrderRequest, completion: @escaping (Result<String>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "orders/cart") else { return }
//            guard let token = APIClient.shared.authToken else {
//                completion(.failure(AuthError.tokenError))
//                return
//            }
//
//            let jsonData = jsonParser.extractEncodedJsonData(data: orderRequest)
//
//            guard let request = requestMaker.makeRequest(url: url,
//                                                         method: .post,
//                                                         headers: ["Content-Type" : "application/json",
//                                                                   "Token \(token)" : "Authorization"],
//                                                         body: jsonData) else {
//                completion(.failure(APIError.requestFailed))
//                return
//            }
//
//            dispatcher.dispatch(request: request) { (result, response) in
//                switch result {
//                case .failure(let error):
//                    completion(.failure(error))
//                case .success(_):
//                    completion(.success(""))
//                }
//
//            }
            
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
                let jsonData = try encoder.encode(orderRequest)
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
        
        func requestOrder(_ orderRequest: OrderRequest, completion: @escaping (Result<String>) -> Void) {
            
            guard let url = URL(string: APIClient.shared.baseURL + "orders/order") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            guard let token = APIClient.shared.authToken else {
                completion(.failure(AuthError.tokenError))
                return
            }
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
                        
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(orderRequest)
                request.httpBody = jsonData
            } catch {
                completion(.failure(error))
                return
            }
            
//            let jsonData = jsonParser.extractEncodedJsonData(data: orderRequest)
            
//            guard let request = requestMaker.makeRequest(url: url,
//                                                         method: .post,
//                                                         headers: ["Content-Type" : "application/json",
//                                                                   "Token \(token)" : "Authorization"],
//                                                         body: jsonData) else {
//                completion(.failure(APIError.requestFailed))
//                return
//            }

//            dispatcher.dispatch(request: request) { (result, response) in
//                switch result {
//                case .failure(let error):
//                    completion(.failure(error))
//                case .success(_):
//                    completion(.success(""))
//                }
//
//            }
            
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
        
        func fetchCart(completion: @escaping (Result<[CartResponse]>) -> Void) {
            
//            guard let url = URL(string: APIClient.shared.baseURL + "orders/cart") else { return }
//
//            guard let token = APIClient.shared.authToken else {
//                completion(.failure(AuthError.tokenError))
//                return
//            }
//
//            guard let request = requestMaker.makeRequest(url: url,
//                                                         method: .post,
//                                                         headers: ["Content-Type" : "application/json",
//                                                                   "Token \(token)" : "Authorization"],
//                                                         body: nil) else {
//                completion(.failure(APIError.requestFailed))
//                return
//            }
//
//
//            dispatcher.dispatch(request: request) { (result, response) in
//                switch result {
//                case .failure(let error):
//                    completion(.failure(error))
//                case .success(let data):
//                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: [CartResponse].self, binaryData: data) else {
//                        completion(.failure(APIError.jsonParsingFailure))
//                        return
//                    }
//                    completion(.success(responseData))
//                }
//            }
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
        
        func fetchOrder(completion: @escaping (Result<[OrderResponse]>) -> Void) {
            
//            guard let url = URL(string: APIClient.shared.baseURL + "orders/order") else { return }
//
//            guard let token = APIClient.shared.authToken else {
//                completion(.failure(AuthError.tokenError))
//                return
//            }
//
//            guard let request = requestMaker.makeRequest(url: url,
//                                                         method: .post,
//                                                         headers: ["Content-Type" : "application/json",
//                                                                   "Token \(token)" : "Authorization"],
//                                                         body: nil) else {
//                completion(.failure(APIError.requestFailed))
//                return
//            }
//
//            dispatcher.dispatch(request: request) { (result, response) in
//                switch result {
//                case .failure(let error):
//                    completion(.failure(error))
//                case .success(let data):
//                    guard let responseData = self.jsonParser.extractDecodedJsonData(decodeType: [OrderResponse].self, binaryData: data) else {
//                        completion(.failure(APIError.jsonParsingFailure))
//                        return
//                    }
//                    completion(.success(responseData))
//                }
//            }
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
        
        func deleteCart(_ orderRequest: OrderRequest, completion: @escaping (Result<String>) -> Void) {
            
//            guard let url = URL(string: APIClient.shared.baseURL + "orders/cart") else { return }
//
//            guard let token = APIClient.shared.authToken else {
//                completion(.failure(AuthError.tokenError))
//                return
//            }
//
//            let jsonData = jsonParser.extractEncodedJsonData(data: orderRequest)
//
//            guard let request = requestMaker.makeRequest(url: url,
//                                                         method: .delete,
//                                                         headers: ["Content-Type" : "application/json",
//                                                                   "Token \(token)" : "Authorization"],
//                                                         body: jsonData) else {
//                completion(.failure(APIError.requestFailed))
//                return
//            }
//
//            dispatcher.dispatch(request: request) { (result, response) in
//                switch result {
//                case .failure(let error):
//                    completion(.failure(error))
//                case .success(_):
//                    completion(.success(""))
//                }
//            }
            
            guard let url = URL(string: APIClient.shared.baseURL + "orders/cart") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let token = APIClient.shared.authToken else {
                completion(.failure(NSError(domain: "Authorization", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token is missing"])))
                return
            }
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(orderRequest)
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
                if let _ = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    completion(.success("Cart deleted successfully"))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
            }
            task.resume()
        }
    }
    
    class AI {
        let requestMaker = RequestMaker()
        var jsonParser = JsonParser()
        let dispatcher = Dispatcher(session: URLSession.shared)
        
        func imageTransFetch(_ image: Data, completion: @escaping(Result<Data>) -> Void) {
            
            guard let url = URL(string: "http://222.101.35.91:8080/predict") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let boundary = "Boundary-\(UUID().uuidString)"
            let contentType = "multipart/form-data; boundary=\(boundary)"
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
            
            var body = Data()

            // 필드 데이터를 추가합니다.
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"file_type\"\r\n\r\n".data(using: .utf8)!)
            body.append("image\r\n".data(using: .utf8)!) // 'file_type' 필드 값

            // 파일 데이터를 추가합니다.
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"source\"; filename=\"image.png\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            body.append(image) // 'source' 필드 값 (이미지 데이터)
            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            request.httpBody = body
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                
                if let data = data {
                    completion(.success(data))
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                    }
                    return
                }
            }
            task.resume()
        }
    }
    
    let auth = Auth()
    let main = Main()
    let cake = Cake()
    let order = Order()
    let ai = AI()
}
