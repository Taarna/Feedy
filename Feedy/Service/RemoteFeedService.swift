//
//  RemoteFeedService.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024.
//

import Foundation
import FeedKit

enum RemoteServiceError: Error {
    case httpError
    case dataError
    case parseError
    case unknownError
}

final class RemoteFeedService: FeedNetworkingService {
    
    private var feedStorage: FeedStorage!
    
    init(with feedStorage: FeedStorage) {
        self.feedStorage = feedStorage
    }
    
    func getFeed(with url: URL) async -> Result<Feed, Error> {
        let parser = FeedParser(URL: url)
        
        return await withCheckedContinuation { continuation in
            parser.parseAsync { result in
                switch result {
                case .success(let feed):
                    if let atomFeed = feed.atomFeed {
                        continuation.resume(returning: .success(Feed(url: atomFeed.title ?? "")))
                    } else if let rssFeed = feed.rssFeed {
                        continuation.resume(returning: .success(Feed(url: rssFeed.title ?? "")))
                    } else if let jsonFeed = feed.jsonFeed {
                        continuation.resume(returning: .success(Feed(url: jsonFeed.title ?? "")))
                    } else {
                        continuation.resume(returning: .failure(RemoteServiceError.parseError))
                    }
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        }
    }
}
