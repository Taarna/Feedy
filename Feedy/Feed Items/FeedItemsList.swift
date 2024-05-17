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
        List(feed.items) { item in
            VStack(alignment: .leading) {
                Text(item.title).font(.headline)
                if let description = item.description {
                    Text(description).font(.subheadline)
                }
            }
        }
        .navigationTitle(feed.title)
    }
}
