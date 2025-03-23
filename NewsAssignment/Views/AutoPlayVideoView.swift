//
//  AutoPlayVideoView.swift
//  NewsAssignment
//
//  Created by Yasir Khan on 23/03/2025.
//

import SwiftUI
import AVKit

// MARK: - AutoPlay Video View
struct AutoPlayVideoView: View {
    let url: URL
    let videoID: UUID
    @State private var player = AVPlayer()
    @EnvironmentObject var playbackManager: VideoPlaybackManager
    
    var body: some View {
        VideoPlayer(player: player)
            .frame(height: 250)
            .cornerRadius(10)
            .onAppear {
                let cachedURL = VideoCacheManager.shared.getCachedVideoURL(for: url)
                player.replaceCurrentItem(with: AVPlayerItem(url: cachedURL))
            }
            .onChange(of: playbackManager.activeVideoID) { newValue in
                if newValue == videoID {
                    player.play()
                } else {
                    player.pause()
                }
            }
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            checkVisibility(proxy: proxy)
                        }
                        .onChange(of: proxy.frame(in: .global)) { _ in
                            checkVisibility(proxy: proxy)
                        }
                }
            )
    }
    
    private func checkVisibility(proxy: GeometryProxy) {
        let frame = proxy.frame(in: .global)
        let screenCenter = UIScreen.main.bounds.midY
        let videoCenter = (frame.minY + frame.maxY) / 2
        let distanceToCenter = abs(screenCenter - videoCenter)

        DispatchQueue.main.async {
            if distanceToCenter < 200 {
                playbackManager.activeVideoID = videoID
            }
        }
    }
}
