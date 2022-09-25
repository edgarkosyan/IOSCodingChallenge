//
//  ProductsListViewModel.swift
//  CodingChallenge
//
//  Created by Edgar on 24.09.22.
//

import Foundation

class ProductsListViewModel: ObservableObject {
    @Published var products: [Product] = []
    private let downloadManager: DownloadManager
    
    init(downloadManager: DownloadManager = DownloadManager.shared) {
        self.downloadManager = downloadManager
        Task {
            await loadData()
        }
    }
    
    func loadData() async {
        do {
            let products = try await downloadManager.downloadData()
            await MainActor.run(body: {
                self.products = products
            })
        } catch {
            print("error: \(error)")
        }
    }
}
