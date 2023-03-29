//
//  LoginViewModel.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/09.
//

import Foundation

protocol LoginModelDelegate: AnyObject {
    func loginModelDidStartLogin(_ model: LoginModel)
    func loginModelDidFinishLogin(_ model: LoginModel, withToken token: String)
    func loginModel(_ model: LoginModel, didFailWithError error: Error)
}

let BASE_URL: String = "http://custommoment.link/"

struct SignUpResponse: Decodable {
    let token: String
}

struct LoginResponse: Decodable {
    let token: String
    let seller: Bool
}

class LoginModel {
    
    weak var delegate: LoginModelDelegate?
    
    func storeUserInfo(_ token: String, _ seller: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(token, forKey: "token")
        userDefaults.set(seller, forKey: "seller")
    }
    
    func getToken() -> String? {
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: "token")
    }
    
    func getSeller() -> Bool? {
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "seller")
    }
    
    func login(email: String, password: String) {
        
        delegate?.loginModelDidStartLogin(self)
        
        guard let url = URL(string: "http://custommoment.link/accounts/login") else {
            let error = NSError(domain: "link.custommoment.login", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            delegate?.loginModel(self, didFailWithError: error)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "email" : email,
            "password" : password
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            delegate?.loginModel(self, didFailWithError: error)
            return
        }
        
        // send the login request using URLSession
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            // check for error
            if let error = error {
                self.delegate?.loginModel(self, didFailWithError: error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let error = NSError(domain: "link.custommomment.accounts/login", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                self.delegate?.loginModel(self, didFailWithError: error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                guard let token = json?["token"] as? String else {
                    let _ = NSError(domain: "link.custommomment.accounts/login", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid token"])
                    return
                }
                guard let seller = json?["is_seller"] as? Bool else {
                    let _ = NSError(domain: "link.custommomment.accounts/login", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid token"])
                    return
                }
                
                let _ = LoginResponse(token: token, seller: seller)
                
                self.storeUserInfo(token, seller)
                
                self.delegate?.loginModelDidFinishLogin(self, withToken: token)
            } catch {
                self.delegate?.loginModel(self, didFailWithError: error)
                return
            }
        }
        task.resume()
    }
    
    func signUp(_ email: String, _ password: String, _ name: String, _ digit: String, _ address: String, _ birth: String){
        
        guard let url = URL(string: BASE_URL + "accounts/signup") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "email" : email,
            "password" : password,
            "name" : name,
            "digit" : digit,
            "birth" : birth,
            "address" : address
        ] as [String : Any]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                guard let token = json?["token"] as? String else {
                    return
                }
                
                let _ = SignUpResponse(token: token)
                self.storeUserInfo(token, false)
                
            } catch {
                return
            }
        }
        task.resume()
    }
    
}
