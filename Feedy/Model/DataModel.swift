//
//  FeedsListModel.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024..
//

import Foundation

class DataModel: ObservableObject {
    private var localStorage: LocalFeedStorage
    private var remoteService: RemoteFeedService
    
    @Published private(set) var feeds: [Feed]
    
    init(with localStorage: LocalFeedStorage, remoteService: RemoteFeedService) {
        self.localStorage = localStorage
        self.remoteService = remoteService
        self.feeds = localStorage.getFeeds()
    }
    
    func add(feedUrl url: String) async {
        if let feedUrl = URL(string: url) {
            let newFeed = await remoteService.getFeed(with: feedUrl)
            switch newFeed {
            case .success(let newFeed):
                localStorage.add(feed: newFeed)
                feeds = localStorage.getFeeds()
            case .failure(let error):
                print("Error")
            }
        }
    }
    
    func remove(feed: Feed) {
        localStorage.remove(feed: feed)
        feeds = localStorage.getFeeds()
    }
}
