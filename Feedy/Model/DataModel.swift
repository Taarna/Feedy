//
//  FeedsListModel.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024.
//

import Foundation
import SwiftData
import FeedKit

@MainActor
class DataModel: ObservableObject {
    private let remoteService: RemoteFeedService
    
    init(with remoteService: RemoteFeedService) {
        self.remoteService = remoteService
    }
    
    func add(feedUrl url: String, into context: ModelContext) async throws {
        guard let feedURL = URL(string: url) else {
            throw FeedyError.incorrectURL
        }
            
        let result = await remoteService.getFeed(with: feedURL)
        switch result {
        case .success(let newFeed):
            insert(newFeed: newFeed, fromURL: feedURL, into: context)
        case .failure(let error):
            throw error
        }
    }
    
    func remove(feed: Feed, fromContext context: ModelContext) {
        context.delete(feed)
    }
    
    func refresh(feed: Feed) async throws {
        guard let feedURL = feed.url else {
            throw FeedyError.incorrectURL
        }
        
        let result = await remoteService.getFeed(with: feedURL)
        switch result {
        case .success(let newFeed):
            update(feed: feed, to: newFeed)
        case .failure(let error):
            throw error
        }
    }
    
    private func insert(newFeed: FKFeed, fromURL url: URL, into context: ModelContext) {
        if let (feed, feedItems) = parse(remoteFeed: newFeed) {
            feed.url = url
            context.insert(feed)
            feedItems.forEach { feedItem in
                feed.items.append(feedItem)
            }
        }
    }
    
    private func update(feed oldFeed: Feed, to new: FKFeed) {
        if let (_, newItems) = parse(remoteFeed: new) {
            let existingItemsSet = Set(oldFeed.items.map { $0.title })
            let newItemsSet = Set(newItems.map { $0.title })
            
            let itemsToDelete = oldFeed.items.filter { !newItemsSet.contains($0.title) }
            let itemsToAdd = newItems.filter { !existingItemsSet.contains($0.title) }
            
            for item in itemsToDelete {
                if let index = oldFeed.items.firstIndex(where: { $0.title == item.title }) {
                    oldFeed.items.remove(at: index)
                }
            }
            
            itemsToAdd.forEach { newItem in
                oldFeed.items.append(newItem)
            }
        }
    }
    
    private func parse(remoteFeed: FKFeed) -> (Feed, [FeedItem])? {
        if let atomFeed = remoteFeed.atomFeed {
            return Parser.parse(atomFeed: atomFeed)
        } else if let rssFeed = remoteFeed.rssFeed {
            return Parser.parse(rssFeed: rssFeed)
        }
        return nil
    }
}
