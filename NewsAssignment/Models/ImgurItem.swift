//
//  ImgurItem.swift
//  NewsAssignment
//
//  Created by Yasir Khan on 23/03/2025.
//

import Foundation

// MARK: - Imgur API Response Model
struct ImgurGalleryResponse: Codable {
    let data: [ImgurItem]
}

struct ImgurItem: Codable {
    let id: String
    let title: String?
    let link: String
    let animated: Bool?
    let images: [ImgurImage]?
}

struct ImgurImage: Codable {
    let link: String
    let animated: Bool?
}
