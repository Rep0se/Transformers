//
//  ApiService.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-08.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import Foundation

class ApiService {
    private init() {}
    static let shared = ApiService()
    
    // MARK: - Convenience Objects
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    struct Constants {
        static let authUrl: String = "https://transformers-api.firebaseapp.com/allspark"
        static let authHeader: Dictionary<String, String> = [
            "Content-Type" : "application/json"
        ]
        static let baseUrl: String = "https://transformers-api.firebaseapp.com/transformers"
        static let apiKey: String = UserDefaults.standard.apiKey()// "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1McWdfMG4wVEZKcEFWMFRsaVRaIiwiaWF0IjoxNTcwNTU4NDUwfQ.PSpAbE3CNZbgTsFzK61-SVQ0V9dSi4DD45SAOMleGTY"
        static let requestHeader: Dictionary<String, String> = [
            "Authorization" : "Bearer \(apiKey)",
            "Content-Type" : "application/json"
        ]
    }
    
    private func request(url: URL, httpMethod: HttpMethod, header: [String: String], body: Transformer? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = header
        if httpMethod == .post || httpMethod == .put {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch let err {
                print("Serialization Error: \(err)")
            }
            
        }
        return request
    }
    
    // MARK: - API Methods
    func authorize(completion: @escaping (String) -> Void){
        guard let url = URL(string: Constants.authUrl) else {
            print("Error: cannot create URL")
            return
        }
        let header = Constants.authHeader
        let session = URLSession.shared
        let task = session.dataTask(with: request(url: url, httpMethod: .get, header: header)) { (data, response, error) in
            guard let data = data else { return }
            if let result = String(data: data, encoding: .utf8){
                print("Authorization Key: \(String(describing: result))")
                completion(result)
            }
        }
        task.resume()
    }
    
    func create(body: Transformer){
            guard let url = URL(string: Constants.baseUrl) else {
                print("Error: cannot create URL")
                return
            }
            let header = Constants.requestHeader
            let session = URLSession.shared
            let task = session.dataTask(with: request(url: url, httpMethod: .post, header: header, body: body)) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(Transformer.self, from: data)
                    print("Transformer Created: \(String(describing: result))")
                } catch let jsonErr {
                    print("Error serializing json: \(jsonErr)")
                }
            }
            task.resume()
        }
    
    func readAll(completion: @escaping ([String: [Transformer?]]) -> Void) {
        guard let url = URL(string: Constants.baseUrl) else {
            print("Error: cannot create URL")
            return
        }
        let header = Constants.requestHeader
        let session = URLSession.shared
        let task = session.dataTask(with: request(url: url, httpMethod: .get, header: header)) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([String: [Transformer]].self, from: data)
                print("All Transformers: \n", result)
                completion(result)
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
        }
        task.resume()
    }
    
    func read(transformerId: String, completion: @escaping (Transformer?) -> Void){
        guard let url = URL(string: Constants.baseUrl + "/\(transformerId)") else {
            print("Error: cannot create URL")
            return
        }
        let header = Constants.requestHeader
        let session = URLSession.shared
        let task = session.dataTask(with: request(url: url, httpMethod: .get, header: header)) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Transformer.self, from: data)
                print("Transformer: \n", result)
                completion(result)
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
        }
        task.resume()
    }
    
    func update(body: Transformer){
        guard let url = URL(string: Constants.baseUrl) else {
            print("Error: cannot create URL")
            return
        }
        let header = Constants.requestHeader
        let session = URLSession.shared
        let task = session.dataTask(with: request(url: url, httpMethod: .put, header: header, body: body)) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Transformer.self, from: data)
                print("Transformer Updated: \(String(describing: result))")
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
        }
        task.resume()
    }
    
    func delete(transformerId: String){
        guard let url = URL(string: Constants.baseUrl + "/\(transformerId)") else {
            print("Error: cannot create URL")
            return
        }
        let header = Constants.requestHeader
        let session = URLSession.shared
        let task = session.dataTask(with: request(url: url, httpMethod: .delete, header: header)) { (data, response, error) in
            guard let data = data else { return }
            let result = String(data: data, encoding: .utf8)
            print("Transformer Deleted: \(String(describing: result))")
        }
        task.resume()
    }
}
