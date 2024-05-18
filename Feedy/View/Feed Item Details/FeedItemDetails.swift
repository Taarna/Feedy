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
            Text("Invalid URL")
        }
    }
}
