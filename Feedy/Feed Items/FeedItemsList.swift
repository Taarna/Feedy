//
//  FeedItemsList.swift
//  Feedy
//
//  Created by Ivana Rast on 17.05.2024.
//

import SwiftUI

struct FeedItemsList: View {
    let feed: Feed
    
    var body: some View {
        List {
            ForEach(feed.items) { feedItem in
                VStack(alignment: .leading) {
                    Text(feedItem.title).font(.headline)
                    if let details = feedItem.details {
                        Text(details).font(.subheadline)
                    }
                }
            }
        }
        .navigationTitle(feed.title)
    }
}
