//
//  FeedRowView.swift
//  NewsAssignment
//
//  Created by Yasir Khan on 23/03/2025.
//

import SwiftUI

// MARK: - Feed Row View
struct FeedRowView: View {
    let item: FeedItem
    @EnvironmentObject var playbackManager: VideoPlaybackManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            switch item.type {
            case .video(let url):
                AutoPlayVideoView(url: url, videoID: item.id)
            case .image(let url):
                CachedImageView(url: url).onAppear() {
                    print(url)
                }
            }
        }
        .padding()
    }
}
