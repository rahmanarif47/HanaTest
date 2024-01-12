//
//  NetworkService.swift
//  HanaTest
//
//  Created by Arif Rahman Sidik on 12/01/24.
//

import Foundation

import Foundation

protocol Service {
    func request(endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class NetworkService: Service {
    func request(endpoint: Endpoint,completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = createTask(url: endpoint.url, completion: completion)
        task.resume()
    }
    
    private func createTask(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
        return URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { completion(data, response, error) }
        }
    }
}
