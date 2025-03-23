//
//  FeedListView.swift
//  NewsAssignment
//
//  Created by Yasir Khan on 23/03/2025.
//

import SwiftUI

// MARK: - ViewModel to Manage Visible Videos
class VideoPlaybackManager: ObservableObject {
    @Published var activeVideoID: UUID?
}

// MARK: - Feed List View
struct FeedListView: View {
    @StateObject private var playbackManager = VideoPlaybackManager()
    @StateObject private var imgurAPI = ImgurAPIService()
    
    var body: some View {
        NavigationView {
            ZStack {
                if imgurAPI.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .font(.headline)
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(imgurAPI.feedItems) { item in
                                FeedRowView(item: item)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Imgur Feed")
            .onAppear {
                imgurAPI.fetchGallery()
            }
        }
        .environmentObject(playbackManager)
    }
}
