//
//  ImageCache.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 1/3/2023.
//

import UIKit

final class ImageCache {
    
    // MARK: - properties
    
    private let cachedImage: NSCache<NSString, UIImage>
    
    init() {
        cachedImage = NSCache<NSString, UIImage>()
    }
    
}

extension ImageCache: ImageCacheProtocol {
    
    /// Caches an image.
    ///
    /// - Parameters:
    ///    - image: The image to be cached.
    ///    - urlString: The image url string of of the image.
    ///
    
    func cacheImage(
        image: UIImage,
        urlString: NSString
    ) {
        self.cachedImage.setObject(image, forKey: urlString)
    }
    
    /// Returns a cached image.
    ///
    /// - Parameters:
    ///    - urlString: The image url string of an image.
    ///
    func getCachedImage(urlString: NSString) -> UIImage? {
        if let cachedImage = self.cachedImage.object(forKey: urlString) {
            return cachedImage
        }
        return nil
    }
    
}
