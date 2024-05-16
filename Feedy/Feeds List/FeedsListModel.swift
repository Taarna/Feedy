//
//  FeedsListModel.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024..
//

import Foundation

@Observable
class FeedsListModel {
    private var localStorage: LocalFeedStorage
    private var service: RemoteFeedService
    
    var feeds: [Feed] = []
    
    init() {
        let localStorage = LocalFeedStorage(with: UserDefaults.standard)
        
        self.localStorage = localStorage
        self.service = RemoteFeedService(with: localStorage)
    }
    
    func add(feedUrl url: String) {
        print("Add feed url")
        let newFeed = Feed(url: "https://www.kodeco.com/feed")
        localStorage.add(feed: newFeed)
        feeds = localStorage.getFeeds()
    }
}
