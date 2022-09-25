//
//  ImageChache.swift
//  CodingChallenge
//
//  Created by Edgar on 25.09.22.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private init() {}
    
    private var cache = {
        var cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}
