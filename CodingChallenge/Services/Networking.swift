//
//  Networking.swift
//  CodingChallenge
//
//  Created by Edgar on 24.09.22.
//

import Foundation

protocol NetworkingProtocol {
    func fetchData(urlString: String) async throws -> Data
}

class Networking: NetworkingProtocol {
    
    enum C: String {
        case urlString = "https://td-ios-coding-challenge.s3.amazonaws.com/product_data/products.json"
        //"https://td-ios-coding-challenge.s3.amazonaws.com/product_data/products_malformed.json"
        //"https://td-ios-coding-challenge.s3.amazonaws.com/product_data/products_empty.json"
    }
    
    enum DownloadError: Error {
        case dataTaskError
        case noResponse
        case wrongResponse
        case debugSkip
        case urlNil
    }
    
    func fetchData(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else { throw DownloadError.urlNil }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                throw DownloadError.wrongResponse
            }
            return data
        } catch {
            throw error
        }
    }
}
