//
//  FeedItemsList.swift
//  Feedy
//
//  Created by Ivana Rast on 17.05.2024.
//

import SwiftUI

struct FeedItemsList: View {
    @Environment(DataModel.self) private var dataModel
    
    let feed: Feed
    
    var body: some View {
        List {
            ForEach(feed.items, id: \.id) { feedItem in
                ZStack(alignment: .leading) {
                    NavigationLink(destination: FeedItemDetails(feedItem: feedItem)) {
                        EmptyView()
                    }.opacity(0)
                    FeedItemCell(feedItem: feedItem)
                }
            }
        }
        .navigationTitle(feed.title)
        .onAppear() {
            Task {
                await dataModel.refreshFeed(feed: feed)
            }
        }
    }
}
