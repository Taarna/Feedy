//
//  FeedStorage.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024..
//

import Foundation

protocol FeedStorage {
    func getFeeds() -> [Feed]
    func save(feeds: [Feed])
    func add(feed: Feed)
}
