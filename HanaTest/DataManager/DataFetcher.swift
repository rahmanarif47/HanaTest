//
//  DataFetcher.swift
//  HanaTest
//
//  Created by Arif Rahman Sidik on 12/01/24.
//

import Foundation

import Foundation

enum PokemonAPIError: Error {
    case badRequest
    case unauthorized
    case tooManyRequests
    case serverError
}

extension PokemonAPIError {
    var errorDescription: String {
        switch self {
        case .badRequest:
            return "The request was unacceptable, often due to a missing or misconfigured parameter"
        case .unauthorized:
            return "Your API key was missing from the request, or wasn't correct"
        case .tooManyRequests:
            return "You made too many requests within a window of time and have been rate limited. Back off for a while"
        case .serverError:
            return "Something went wrong on our side."
        }
    }
}

protocol DataFetcher {
//    func getSource(endpoint: Endpoint,completion: @escaping (Result<[Source], PokemonAPIError>) -> Void)
//    func getArticle(endpoint: Endpoint,completion: @escaping (Result<[Article], PokemonAPIError>) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    private let service: Service
    
    init(service: Service) {
        self.service = service
    }
    
    func getSource(endpoint: Endpoint,completion: @escaping (Result<PokemonListEntity, PokemonAPIError>) -> Void) {
        service.request(endpoint: endpoint) { data, response, error in
            if let _ = error {
                completion(.failure(.badRequest))
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            
            switch response.statusCode {
            case 200:
                if let decode = self.decode(jsonData: PokemonListEntity.self, from: data) {
                    completion(.success(decode))
                }
            case 400:
                completion(.failure(.badRequest))
            case 401:
                completion(.failure(.unauthorized))
            case 429:
                completion(.failure(.tooManyRequests))
            case 500:
                
                completion(.failure(.serverError))
            default:
                break
            }
        }
    }
    
    func getArticle(endpoint: Endpoint, completion: @escaping (Result<[Article], PokemonAPIError>) -> Void) {
        service.request(endpoint: endpoint) { data, response, error in
            if let _ = error {
                completion(.failure(.badRequest))
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            
            switch response.statusCode {
            case 200:
                if let decode = self.decode(jsonData: ArticlesResponse.self, from: data) {
                    completion(.success(decode.articles))
                }
            case 400:
                completion(.failure(.badRequest))
            case 401:
                completion(.failure(.unauthorized))
            case 429:
                completion(.failure(.tooManyRequests))
            case 500:
                completion(.failure(.serverError))
            default:
                break
            }
        }
    }
    
    private func decode<T: Decodable>(jsonData type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = data else { return nil }
        
        do {
            let response = try decoder.decode(type, from: data)
            return response
        } catch {
            print(error)
            return nil
        }
    }
}
