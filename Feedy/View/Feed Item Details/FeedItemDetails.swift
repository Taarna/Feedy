//
//  FeedItemDetails.swift
//  Feedy
//
//  Created by Ivana Rast on 18.05.2024.
//

import SwiftUI

struct FeedItemDetails: View {
    let feedItem: FeedItem

    var body: some View {
        if let url = feedItem.link {
            WebView(url: url)
                .navigationTitle(feedItem.title)
        } else {
            ContentUnavailableView(
                "The link is missing for \"\(feedItem.title)\"",
                systemImage: "exclamationmark.octagon",
                description: nil
            )
        }
    }
}
