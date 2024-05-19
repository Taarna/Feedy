//
//  Parser.swift
//  Feedy
//
//  Created by Ivana Rast on 19.05.2024.
//

import Foundation
import FeedKit

struct Parser {
    
    static func parse(atomFeed: AtomFeed) -> (Feed, [FeedItem])? {
        let feed = atomFeed.toFeed()
        let feedItems = atomFeed.entries?.map { entry in
            FeedItem(
                title: entry.title ?? "",
                details: entry.summary?.value ?? "",
                imageURL: entry.media?.mediaThumbnails?.first?.attributes?.url.flatMap(URL.init(string:)),
                link: entry.links?.first?.attributes?.href.flatMap(URL.init(string:))
            )
        } ?? []
        return (feed, feedItems)
    }
    
    static func parse(rssFeed: RSSFeed) -> (Feed, [FeedItem])? {
        let feed = rssFeed.toFeed()
        let feedItems = rssFeed.items?.map { item in
            FeedItem(
                title: item.title ?? "",
                details: item.description,
                imageURL: item.link.flatMap(URL.init(string:)),
                link: item.link.flatMap(URL.init(string:))
            )
        } ?? []
        return (feed, feedItems)
    }
}
