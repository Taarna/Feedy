//
//  RemoteFeedService.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024.
//

import Foundation
import FeedKit

final class RemoteFeedService {
    
    func getFeed(with url: URL) async -> Result<FKFeed, ParserError> {
        let parser = FeedParser(URL: url)
        
        return await withCheckedContinuation { continuation in
            parser.parseAsync { result in
                switch result {
                case .success(let feed):
                    continuation.resume(returning: .success(feed))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        }
    }
}
