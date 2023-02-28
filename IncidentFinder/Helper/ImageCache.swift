//
//  ImageCache.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 1/3/2023.
//

import UIKit

final class ImageCache {
    
    private let cachedImage: NSCache<NSString, UIImage>
    
    init() {
        cachedImage = NSCache<NSString, UIImage>()
    }
    
}

extension ImageCache: ImageCacheProtocol {
    
    func cacheImage(
        image: UIImage,
        urlString: NSString
    ) {
        self.cachedImage.setObject(image, forKey: urlString)
    }
    
    func getCachedImage(urlString: NSString) -> UIImage? {
        if let cachedImage = self.cachedImage.object(forKey: urlString) {
            return cachedImage
        }
        return nil
    }
    
}
