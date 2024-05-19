//
//  AtomFeed+FeedConvertible.swift
//  Feedy
//
//  Created by Ivana Rast on 20.05.2024.
//

import Foundation
import FeedKit

extension AtomFeed: FeedConvertible {
    func toFeed() -> Feed {
        return Feed(
            url: "",
            title: self.title ?? "",
            details: self.subtitle?.value ?? "",
            imageURL: URL(string: self.logo ?? ""),
            items: []
        )
    }
}
