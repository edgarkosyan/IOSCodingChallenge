//
//  ProductsListView.swift
//  CodingChallenge
//
//  Created by Edgar on 24.09.22.
//

import SwiftUI

struct ProductsListView: View {
    @ObservedObject var viewModel: ProductsListViewModel
    @State var shouldShowTextField: Bool = false
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("Products")
                        .font(.title)
                        .padding()
                    Spacer()
                }
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .bold(shouldShowTextField)
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            shouldShowTextField.toggle()
                        }
                    }
            }
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.products) { product in
                        ItemView(product: product)
                            .background(Color.white
                                .cornerRadius(7)
                                .shadow(color: .gray.opacity(0.3), radius: 3, x: -2, y: -2)
                                
                            )
                            
                            .padding()
                    }
                }
            }
        }
        .background(Color.white)
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView(viewModel: ProductsListViewModel())
    }
}
