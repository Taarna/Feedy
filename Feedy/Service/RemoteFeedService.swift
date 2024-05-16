//
//  RemoteFeedService.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024.
//

import Foundation

final class RemoteFeedService: FeedNetworkingService {
    
    private var feedStorage: FeedStorage!
    
    init(with feedStorage: FeedStorage) {
        self.feedStorage = feedStorage
    }
    
    func getFeed(with url: URL) async -> Result<Feed, Error> {
        do {
            let feed = Feed(url: "https://www.kodeco.com/feed") //try await 
            return .success(feed)
        } catch let error {
            return .failure(error)
        }
    }
}
