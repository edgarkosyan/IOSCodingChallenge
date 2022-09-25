//
//  DownloadManage.swift
//  CodingChallenge
//
//  Created by Edgar on 24.09.22.
//

import Foundation

class DownloadManager {
    static let shared = DownloadManager()
    private let networking: NetworkingProtocol
    
    private init(networking: NetworkingProtocol = Networking()) {
        self.networking = networking
    }
    
    func downloadData() async throws -> [Product] {
        do {
            let data = try await networking.fetchData(urlString: Networking.C.urlString.rawValue)
            let jsonContent = try JSONDecoder().decode(FetchedData.self, from: data)
            print("Count: \(jsonContent.products.count)")
            return jsonContent.products
        } catch {
            throw error
        }
    }
    
    func downloadImageData(urlString: String) async throws -> Data {
        do {
            let data = try await networking.fetchData(urlString: urlString)
            return data
        } catch {
            throw error
        }
    }
}
