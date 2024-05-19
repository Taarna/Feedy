//
//  Feed.swift
//  Feedy
//
//  Created by Ivana Rast on 15.05.2024.
//

import Foundation
import SwiftData

@Model
final class Feed {
    var id = UUID()
    var url: String
    var title: String
    var details: String?
    var imageURL: URL?
    @Relationship(deleteRule: .cascade, inverse: \FeedItem.feed) var items: [FeedItem] = [FeedItem]()
    var isFavorite: Bool
    
    init(
        id: UUID = UUID(),
        url: String,
        title: String,
        details: String? = nil,
        imageURL: URL? = nil,
        items: [FeedItem]) {
            self.id = id
            self.url = url
            self.title = title
            self.details = details
            self.imageURL = imageURL
            self.items = items
            self.isFavorite = false
        }
}
