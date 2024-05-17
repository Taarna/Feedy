//
//  FeedItem.swift
//  Feedy
//
//  Created by Ivana Rast on 17.05.2024.
//

import Foundation

struct FeedItem: Codable, Identifiable {
    var id = UUID()
    var title: String
    var description: String?
    var imageURL: URL?
}
