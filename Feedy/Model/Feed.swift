//
//  Feed.swift
//  Feedy
//
//  Created by Ivana Rast on 15.05.2024.
//

import Foundation

struct Feed: Codable, Identifiable {
    var id = UUID()
    var url: String
    var title: String
    var description: String?
    var imageURL: URL?
    var items: [FeedItem]
}
