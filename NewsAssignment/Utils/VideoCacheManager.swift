//
//  VideoCacheManager.swift
//  NewsAssignment
//
//  Created by Yasir Khan on 23/03/2025.
//

import Foundation

// MARK: - Video Caching Manager
class VideoCacheManager {
    static let shared = VideoCacheManager()
    private var cachedURLs = [URL: URL]()

    func getCachedVideoURL(for url: URL) -> URL {
        if let cachedURL = cachedURLs[url] {
            return cachedURL
        }
        
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent(url.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            cachedURLs[url] = fileURL
            return fileURL
        }
        
        URLSession.shared.downloadTask(with: url) { localURL, _, _ in
            if let localURL = localURL {
                try? FileManager.default.moveItem(at: localURL, to: fileURL)
                self.cachedURLs[url] = fileURL
            }
        }.resume()

        return url
    }
}
