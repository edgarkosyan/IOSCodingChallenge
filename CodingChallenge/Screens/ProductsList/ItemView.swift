//
//  ItemView.swift
//  CodingChallenge
//
//  Created by Edgar on 25.09.22.
//

import SwiftUI

struct ItemView: View {
    var product: Product
    var body: some View {
        HStack {
            ImageView(urlString: product.imageURLSmall)
                .frame(width: 100, height: 100)
                
            Text("name: \(product.brandName ?? "")")
            Spacer()
        }
        .frame(height: 110)
    }
}

struct ItemView_Previews: PreviewProvider {
    static let product = Product(id: "", productName: "", brandName: "", productDescription: "", imageURLSmall: "", imageURLLarge: "", productCategory: "", hazardRating: 2, hazardRatingCategory: .clean)
    static var previews: some View {
        ItemView(product: product)
    }
}
