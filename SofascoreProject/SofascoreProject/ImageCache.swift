//
//  ImageCache.swift
//  SofascoreProject
//
//  Created by Sven Leko on 29.05.2024..
//

import Foundation
import UIKit
import AlamofireImage

class ImageCache {
    
    private let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100 * 1024 * 1024, // 100 MB
        preferredMemoryUsageAfterPurge: 60 * 1024 * 1024 // 60 MB
    )

    func getImage(forKey key: String) -> UIImage? {
        return imageCache.image(withIdentifier: key)
    }

    func setImage(_ image: UIImage, forKey key: String) {
        imageCache.add(image, withIdentifier: key)
    }
}

