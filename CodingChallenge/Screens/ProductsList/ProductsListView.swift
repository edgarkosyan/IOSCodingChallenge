//
//  ProductsListView.swift
//  CodingChallenge
//
//  Created by Edgar on 24.09.22.
//

import SwiftUI

struct ProductsListView: View {
    @ObservedObject var viewModel: ProductsListViewModel
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.products) { product in
                        ItemView(product: product)
                    }
                }
            }
        }
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView(viewModel: ProductsListViewModel())
    }
}
