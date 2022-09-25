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
        HStack(alignment: .top) {
            VStack {
                Spacer()
                ImageView(urlString: product.imageURLSmall)
                    .frame(width: 130, height: 130)
                Spacer()
            }
            .background(Color.white)
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.brandName ?? "")
                        .font(.callout)
                        .bold()
                    Text(product.productCategory ?? "")
                        .font(.caption)
                        .foregroundColor(Color.cyan)
                        .bold()
                    Text(product.productName ?? "")
                        .font(.caption2)
                        .lineLimit(2, reservesSpace: true)
                        .italic()
                }
                .padding(.top, 4)
                Spacer()
                VStack(spacing: 10) {
                    Text(product.productDescription ?? "")
                        .lineLimit(2)
                        .font(.caption)
                        .padding(.top, 5)
                    HStack(spacing: 2) {
                        starsView
                            .overlay (
                                overlayView
                                    .mask(starsView)
                            )
                        Text("(\(String(format: "%.1f", hazardRate(rating: Double(product.hazardRating ?? 0)))))")
                            .font(.caption)
                        Spacer()
                    }
                }
                .padding(.bottom, 7)
            }
            Spacer()
        }
        .frame(height: 150)
        .background(Color.itemGradientColor.opacity(0.2))
        .cornerRadius(7)
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            Rectangle()
                .foregroundColor(.cyan)
                .frame(width: geometry.size.width * starsFillValue(rating: Double(product.hazardRating ?? 0)))
        }
    }
    
    private var starsView: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { _ in
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    func hazardRate(rating: Double) -> Double {
        return 5 * starsFillValue(rating: rating)
    }
    
    func starsFillValue(rating: Double) -> Double {
        let maxRatingNumber: Double = 8
        
        if rating > 0 {
            if rating == maxRatingNumber {
                return 0
            }
            return rating / maxRatingNumber
        }
        return 1
    }
}

struct ItemView_Previews: PreviewProvider {
    static let product = Product(id: "", productName: "", brandName: "", productDescription: "", imageURLSmall: "", imageURLLarge: "", productCategory: "", hazardRating: 2, hazardRatingCategory: .clean)
    static var previews: some View {
        ItemView(product: product)
    }
}
