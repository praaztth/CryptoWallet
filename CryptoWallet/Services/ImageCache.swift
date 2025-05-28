//
//  ImageCache.swift
//  CryptoWallet
//
//  Created by катенька on 28.05.2025.
//

import Foundation

protocol ImageCacheProtocol {
    func imageData(for id: String) -> Data?
    func storeImageData(imageData: Data, for key: String)
}

final class ImageCache: ImageCacheProtocol {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, NSData>()
    
    func imageData(for id: String) -> Data? {
        return cache.object(forKey: id as NSString) as Data?
    }
    
    func storeImageData(imageData: Data, for key: String) {
        cache.setObject(imageData as NSData, forKey: key as NSString)
    }
    
    
    
    
}
