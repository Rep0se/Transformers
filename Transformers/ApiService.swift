//
//  ApiService.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-08.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct ApiConstants {
    static let authUrl: String = "https://transformers-api.firebaseapp.com/allspark"
    static let authHeader: Dictionary<String, String> = [
        "Content-Type" : "application/json"
    ]
    static let baseUrl: String = "https://transformers-api.firebaseapp.com/transformers"
    static let apiKey: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1McWdfMG4wVEZKcEFWMFRsaVRaIiwiaWF0IjoxNTcwNTU4NDUwfQ.PSpAbE3CNZbgTsFzK61-SVQ0V9dSi4DD45SAOMleGTY"
    static let requestHeader: Dictionary<String, String> = [
        "Authorization" : "Bearer \(apiKey)",
        "Content-Type" : "application/json"
    ]
}

class ApiService {
    private init() {}
    static let shared = ApiService()
    
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
    func authorize() -> String? {
        var result: String? = nil
        guard let url = URL(string: ApiConstants.authUrl) else {
            print("Error: cannot create URL")
            return result
        }
        let header = ApiConstants.authHeader
        let session = URLSession.shared
        let task = session.dataTask(with: request(url: url, httpMethod: .get, header: header)) { (data, response, error) in
            guard let data = data else { return }
            result = String(data: data, encoding: .utf8)
            print("Authorization Key: \(String(describing: result))")
        }
        task.resume()
        return result
    }
    
    func create(body: Transformer) -> Transformer? {
            var transformer: Transformer? = nil
            guard let url = URL(string: ApiConstants.baseUrl) else {
                print("Error: cannot create URL")
                return transformer
            }
            let header = ApiConstants.requestHeader
            let session = URLSession.shared
            let task = session.dataTask(with: request(url: url, httpMethod: .post, header: header, body: body)) { (data, response, error) in
                guard let data = data else { return }
                do {
                    transformer = try JSONDecoder().decode(Transformer.self, from: data)
                    print("Transformer Created: \(String(describing: transformer))")
                } catch let jsonErr {
                    print("Error serializing json: \(jsonErr)")
                }
            }
            task.resume()
            return transformer
        }
    
    func readAll() -> [String: [Transformer?]] {
        let transformer: Transformer? = nil
        var result = ["":[transformer]]
        guard let url = URL(string: ApiConstants.baseUrl) else {
            print("Error: cannot create URL")
            return result
        }
        let header = ApiConstants.requestHeader
        let session = URLSession.shared
        let task = session.dataTask(with: request(url: url, httpMethod: .get, header: header)) { (data, response, error) in
            guard let data = data else { return }
            do {
                result = try JSONDecoder().decode([String: [Transformer]].self, from: data)
                print("All Transformers: \n", result)
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
        }
        task.resume()
        return result
    }
    
    func read(transformerId: String)  -> Transformer? {
        var transformer: Transformer? = nil
        guard let url = URL(string: ApiConstants.baseUrl + "/\(transformerId)") else {
            print("Error: cannot create URL")
            return transformer
        }
        let header = ApiConstants.requestHeader
        let session = URLSession.shared
        let task = session.dataTask(with: request(url: url, httpMethod: .get, header: header)) { (data, response, error) in
            guard let data = data else { return }
            do {
                transformer = try JSONDecoder().decode(Transformer.self, from: data)
                print("Transformer: \n", transformer ?? "Does not exist")
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
        }
        task.resume()
        return transformer
    }
    
    func update(body: Transformer) -> Transformer? {
        var transformer: Transformer? = nil
        guard let url = URL(string: ApiConstants.baseUrl) else {
            print("Error: cannot create URL")
            return transformer
        }
        let header = ApiConstants.requestHeader
        let session = URLSession.shared
        let task = session.dataTask(with: request(url: url, httpMethod: .put, header: header, body: body)) { (data, response, error) in
            guard let data = data else { return }
            do {
                transformer = try JSONDecoder().decode(Transformer.self, from: data)
                print("Transformer Updated: \(String(describing: transformer))")
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
        }
        task.resume()
        return transformer
    }
    
    func delete(transformerId: String){
        guard let url = URL(string: ApiConstants.baseUrl + "/\(transformerId)") else {
            print("Error: cannot create URL")
            return
        }
        let header = ApiConstants.requestHeader
        let session = URLSession.shared
        let task = session.dataTask(with: request(url: url, httpMethod: .delete, header: header)) { (data, response, error) in
            guard let data = data else { return }
            let result = String(data: data, encoding: .utf8)
            print("Transformer Deleted: \(String(describing: result))")
        }
        task.resume()
    }
}
