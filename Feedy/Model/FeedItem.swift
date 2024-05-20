//
//  FeedItem.swift
//  Feedy
//
//  Created by Ivana Rast on 17.05.2024.
//

import Foundation
import SwiftData

@Model
final class FeedItem {
    var id = UUID()
    var title: String
    var details: String?
    var imageURL: URL?
    var link: URL?
    var feed: Feed?
    
    init(
        id: UUID = UUID(),
        title: String,
        details: String? = nil,
        imageURL: URL? = nil,
        link: URL? = nil,
        feed: Feed? = nil) {
            self.id = id
            self.title = title
            self.details = details
            self.imageURL = imageURL
            self.link = nil
            self.feed = feed
        }
}
