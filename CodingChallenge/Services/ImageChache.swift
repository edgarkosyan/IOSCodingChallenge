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
    
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}
