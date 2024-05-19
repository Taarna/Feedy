//
//  RSSFeed+FeedConvertible.swift
//  Feedy
//
//  Created by Ivana Rast on 20.05.2024..
//

import Foundation
import FeedKit

extension RSSFeed: FeedConvertible {
    func toFeed() -> Feed {
        return Feed(
            url: "",
            title: self.title ?? "",
            details: self.description,
            imageURL: URL(string: self.image?.url ?? ""),
            items: []
        )
    }
}
