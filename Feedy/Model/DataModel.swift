//
//  FeedsListModel.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024.
//

import Foundation
import SwiftData

@Observable
class DataModel {
    private var remoteService: RemoteFeedService
    
    init(with remoteService: RemoteFeedService) {
        self.remoteService = remoteService
    }
    
    func add(feedUrl url: String, into context: ModelContext) async {
        if let feedUrl = URL(string: url) {
            let newFeed = await remoteService.getFeed(with: feedUrl)
            switch newFeed {
            case .success(let newFeed):
                context.insert(newFeed)
            case .failure(let error):
                print("Error")
            }
        }
    }
    
    func remove(feed: Feed, fromContext context: ModelContext) {
        context.delete(feed)
    }
}
