//
//  CachedImageView.swift
//  NewsAssignment
//
//  Created by Yasir Khan on 23/03/2025.
//

import SwiftUI

// MARK: - Cached Image View
struct CachedImageView: View {
    let url: URL
    @State private var image: UIImage? = nil

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .onAppear {
                        ImageCacheManager.shared.loadImage(url: url) { loadedImage in
                            self.image = loadedImage
                        }
                    }
            }
        }
        .frame(height: 250)
        .cornerRadius(10)
    }
}
