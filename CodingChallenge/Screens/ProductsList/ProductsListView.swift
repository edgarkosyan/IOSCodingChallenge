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
        VStack(spacing: 0) {
            navigationView()
                .background(Color.white)
                .zIndex(1)
            if viewModel.shouldShowTextField {
                TextField("Search", text: $viewModel.textFieldText)
                    .padding(7)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.gray.opacity(0.8))
                    .cornerRadius(7)
                    .padding(.horizontal)
                    .transition(.move(edge: .top))
            }
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.filteredProducts) { product in
                        ItemView(product: product)
                            .background(Color.white
                                .cornerRadius(7)
                                .shadow(color: .gray.opacity(0.3), radius: 3, x: -2, y: -2)
                            )
                            .padding()
                    }
                }
            }
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.immediately)
            .refreshable {
                Task {
                    await viewModel.loadData()
                }
            }
        }
        .background(Color.white)
    }
    
    func navigationView() -> some View {
        ZStack(alignment: .trailing) {
            HStack(alignment: .center) {
                Spacer()
                Text("Products")
                    .font(.title)
                Spacer()
            }
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .bold(viewModel.shouldShowTextField)
                .padding(.trailing)
                .onTapGesture {
                    withAnimation {
                        viewModel.shouldShowTextField.toggle()
                        
                    }
                    if !viewModel.shouldShowTextField {
                        viewModel.refreshProducts()
                    }
                }
        }
        .padding(7)
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView(viewModel: ProductsListViewModel())
    }
}
