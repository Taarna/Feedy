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

final class RemoteFeedService: RemoteService {
    
    func getFeed(with url: URL) async -> Result<Feed, Error> {
        let parser = FeedParser(URL: url)
        
        return await withCheckedContinuation { continuation in
            parser.parseAsync { result in
                switch result {
                case .success(let feed):
                    if let atomFeed = feed.atomFeed {
                        continuation.resume(returning: .success(atomFeed.toFeed()))
                    } else if let rssFeed = feed.rssFeed {
                        continuation.resume(returning: .success(rssFeed.toFeed()))
                    }
//                    else if let jsonFeed = feed.jsonFeed {
//                        continuation.resume(returning: .success(jsonFeed.toFeed()))
//                    }
                    else {
                        continuation.resume(returning: .failure(RemoteServiceError.parseError))
                    }
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        }
    }
}

protocol FeedConvertible {
    func toFeed() -> Feed
}

extension AtomFeed: FeedConvertible {
    func toFeed() -> Feed {
        return Feed(
            url: self.links?.first?.attributes?.href ?? "",
            title: self.title ?? "",
            details: self.subtitle?.value ?? "",
            imageURL: URL(string: self.logo ?? ""),
            items: self.entries?.map { entry in
                FeedItem(
                    title: entry.title ?? "",
                    details: entry.summary?.value ?? "",
                    imageURL: entry.links?.first?.attributes?.href.flatMap(URL.init(string:)),
                    link: entry.links?.first?.attributes?.href.flatMap(URL.init(string:))
                )
            } ?? []
        )
    }
}

extension RSSFeed: FeedConvertible {
    func toFeed() -> Feed {
        return Feed(
            url: self.link ?? "",
            title: self.title ?? "",
            details: self.description,
            imageURL: URL(string: self.image?.url ?? ""),
            items: self.items?.map { item in
                FeedItem(
                    title: item.title ?? "",
                    details: item.description,
                    imageURL: item.link.flatMap(URL.init(string:)),
                    link: item.link.flatMap(URL.init(string:))
                )
            } ?? []
        )
    }
}

//extension JSONFeed: FeedConvertible {
//    func toFeed() -> Feed {
//        return Feed(
//            url: self.homePageURL ?? "",
//            title: self.title ?? "",
//            description: self.description,
//            imageURL: URL(string: self.icon ?? "")
//        )
//    }
//}
