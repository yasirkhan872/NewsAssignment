//
//  FeedItem.swift
//  NewsAssignment
//
//  Created by Yasir Khan on 23/03/2025.
//

import Foundation

// MARK: - Feed Item Model
struct FeedItem: Identifiable {
    enum ContentType {
        case video(url: URL)
        case image(url: URL)
    }
    
    let id = UUID()
    let type: ContentType
}
