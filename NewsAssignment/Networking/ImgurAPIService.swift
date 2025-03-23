//
//  ImgurAPIService.swift
//  NewsAssignment
//
//  Created by Yasir Khan on 23/03/2025.
//

import Foundation

class ImgurAPIService: ObservableObject {
    @Published var feedItems: [FeedItem] = []
    @Published var isLoading: Bool = true
    private let clientID = "ac5b03d42a63760"
    
    func fetchGallery() {
        isLoading = true
        let urlString = "https://api.imgur.com/3/gallery/hot/viral/0.json"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(ImgurGalleryResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.feedItems = decodedResponse.data.compactMap { item in
                            var mediaURL: URL?
                            
                            // ✅ If it's an album, get the first image/video inside it
                            if let images = item.images, let firstImage = images.first {
                                mediaURL = URL(string: firstImage.link)
                            }
                            // ✅ If it's a direct link, use it
                            else if let linkURL = URL(string: item.link),
                                    (item.link.hasSuffix(".jpg") || item.link.hasSuffix(".png") ||
                                     item.link.hasSuffix(".mp4") || item.link.hasSuffix(".gif")) {
                                mediaURL = linkURL
                            }
                            
                            // ✅ If no valid media URL, skip this item
                            guard let finalURL = mediaURL else { return nil }
                            
                            // ✅ Check if it's an image or video
                            if finalURL.pathExtension == "mp4" || finalURL.pathExtension == "gif" {
                                return FeedItem(type: .video(url: finalURL))
                            } else {
                                return FeedItem(type: .image(url: finalURL))
                            }
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
