//
//  ImageCacheProtocol.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 1/3/2023.
//

import UIKit

protocol ImageCacheProtocol {
    func cacheImage(image: UIImage, urlString: NSString)
    func getCachedImage(urlString: NSString) -> UIImage?
}
