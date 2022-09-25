//
//  ProductsListViewModel.swift
//  CodingChallenge
//
//  Created by Edgar on 24.09.22.
//

import Foundation
import Combine

class ProductsListViewModel: ObservableObject {
    @Published var filteredProducts: [Product] = []
    @Published var shouldShowTextField: Bool = false
    @Published var textFieldText: String = ""
    
    var products: [Product] = []
    private var bag = Set<AnyCancellable>()
    private let downloadManager: DownloadManager
    
    init(downloadManager: DownloadManager = DownloadManager.shared) {
        self.downloadManager = downloadManager
        subscribeForTextFieldTextChange()
        Task {
            await loadData()
        }
    }
    
    func loadData() async {
        do {
            let products = try await downloadManager.downloadData()
            await MainActor.run(body: {
                self.products = products
                self.refreshProducts()
            })
        } catch {
            print("error: \(error)")
        }
    }
    
    func refreshProducts() {
        filteredProducts = products
    }
    
    private func subscribeForTextFieldTextChange() {
        $textFieldText
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .sink { val in
                if val.isEmpty {
                    self.refreshProducts()
                }
                if self.shouldShowTextField && !val.isEmpty {
                    self.filteredProducts = self.filterData(value: val.lowercased())
                }
            }.store(in: &bag)
    }
    
    func filterData(value: String) -> [Product] {
        self.products.filter { product in
            if let brandName = product.brandName, let productName = product.productName, let category = product.productCategory {
                if brandName.lowercased().contains(value) || productName.lowercased().contains(value) || category.lowercased().contains(value) {
                    return true
                }
            }
            return false
        }
    }
}
