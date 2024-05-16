//
//  LocalFeedStorage.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024.
//

import Foundation

final class LocalFeedStorage: FeedStorage {
    
    private var storage: DataStorage!
    private let feedsListKey = "FEEDS_LIST_KEY"
    
    init(with storage: DataStorage) {
        self.storage = storage
    }
    
    func getFeeds() -> [Feed] {
        do {
            if let feeds = try storage.get(objectType: [Feed].self, forKey: feedsListKey) {
                return feeds
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func save(feeds: [Feed]) {
        do {
            try storage.set(object: feeds, forKey: feedsListKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func add(feed: Feed) {
        var feeds = getFeeds()
        feeds.append(feed)
        save(feeds: feeds)
    }
    
    func remove(feed: Feed) {
        let feedId = feed.id
        var feeds = getFeeds()
        feeds.removeAll { feed in
            feed.id == feedId
        }
        save(feeds: feeds)
    }
}
