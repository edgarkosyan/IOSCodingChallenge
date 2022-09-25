//
//  Model.swift
//  CodingChallenge
//
//  Created by Edgar on 24.09.22.
//

import Foundation

struct FetchedData: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable, Identifiable {
    let id: String?
    let productName: String?
    let brandName: String?
    let productDescription: String?
    let imageURLSmall: String?
    let imageURLLarge: String?
    let productCategory: String?
    let hazardRating: Int?
    let hazardRatingCategory: HazardRatingCategory?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case productName = "product_name"
        case brandName = "brand_name"
        case productDescription = "description"
        case imageURLSmall = "image_url_small"
        case imageURLLarge = "image_url_large"
        case productCategory = "product_category"
        case hazardRating = "hazard_rating"
        case hazardRatingCategory = "hazard_rating_category"
    }
}

enum HazardRatingCategory: String, Codable {
    case clean = "CLEAN"
    case dirty = "DIRTY"
    case halfAndHalf = "HALF_AND_HALF"
}
