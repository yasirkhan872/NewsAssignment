//
//  ImageCacheManager.swift
//  NewsAssignment
//
//  Created by Yasir Khan on 23/03/2025.
//

import Foundation
import UIKit
// MARK: - Image Caching Manager
class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = URLCache(memoryCapacity: 50_000_000, diskCapacity: 100_000_000, diskPath: "imageCache")

    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: url)
        if let cachedResponse = cache.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            completion(image)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, _ in
            if let data = data, let response = response, let image = UIImage(data: data) {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                self.cache.storeCachedResponse(cachedResponse, for: request)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
