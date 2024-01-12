//
//  HTTPClient.swift
//  HanaTest
//
//  Created by Arif Rahman Sidik on 12/01/24.
//


import Foundation
import RxSwift

protocol ClientAPI {
    var httpClient: HTTPClient { get }
}

protocol HTTPClient {
    func send<T: Codable>(request apiRequest: HTTPRequest) -> Single<T>
    func send<T: Codable>(request apiRequest: HTTPRequestUpload) -> Single<T>
    func verify() -> Completable
}

protocol HTTPIdentifier {
    var baseUrl: URL { get }
}

class BaseIdentifier: HTTPIdentifier {
    #if DEBUG
    var baseUrl = URL(string: "https://api.pokemontcg.io/v2")
    #else
    var baseUrl = URL(string: "https://api.pokemontcg.io/v2")
    #endif
}

class SocketIdentifier: HTTPIdentifier {
    #if DEBUG
    var baseUrl = URL(string: "https://api.pokemontcg.io/v2")!
    #else
    var baseUrl = URL(string: "https://api.pokemontcg.io/v2")!
    #endif
}
