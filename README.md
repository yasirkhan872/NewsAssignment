News Assignment

A SwiftUI-based Imgur feed app that displays images, videos, and text content from the Imgur API. It features smooth scrolling, auto-playing videos, and optimized caching for media.

Features

Fetches latest posts from Imgur API (/gallery/hot/viral/0.json).
Supports images, videos, and text-based posts.
Auto-plays only one visible video at a time.
Implements caching for efficient media loading.
Displays a loader until data is fetched.
Uses LazyVStack for optimized scrolling.
Tech Stack

SwiftUI – UI framework
AVKit – Video playback
URLSession – API requests
Cache System – Image & video caching
Installation

Clone the repository:
git clone https://github.com/yasirkhan872/NewsAssignment.git
cd NewsAssignment
Open NewsAssignment.xcodeproj in Xcode.
Replace YOUR_CLIENT_ID in ImgurAPIService.swift with your Imgur API Client ID.
Run the project on a simulator or device.
