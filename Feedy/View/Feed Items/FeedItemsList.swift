//
//  FeedItemsList.swift
//  Feedy
//
//  Created by Ivana Rast on 17.05.2024.
//

import SwiftUI
import SVGView

struct FeedItemsList: View {
    let feed: Feed
    
    var body: some View {
        List {
            ForEach(feed.items) { feedItem in
                ZStack(alignment: .leading) {
                    NavigationLink(destination: FeedItemDetails(feedItem: feedItem)) {
                        EmptyView()
                    }.opacity(0)
                    HStack {
                        if let imageURL = feedItem.imageURL {
                            AsyncImage(url: imageURL) { image in
                                image.resizable().aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 30, height: 30)
                        } else {
                            let logoURL = Bundle.main.url(forResource: "rss-logo", withExtension: "svg")!
                            SVGView(contentsOf: logoURL).frame(width: 30, height: 30)
                        }
                        VStack(alignment: .leading) {
                            Text(feedItem.title).font(.headline)
                            if let details = feedItem.details {
                                Text(details).font(.subheadline)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(feed.title)
    }
}
