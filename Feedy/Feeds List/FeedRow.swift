//
//  FeedRow.swift
//  Feedy
//
//  Created by Ivana Rast on 17.05.2024.
//

import SwiftUI
import SVGView

struct FeedRow: View {
    let feed: Feed
    
    var body: some View {
        ZStack(alignment: .leading) {
            NavigationLink(destination: FeedItems(feed: feed)) {
                EmptyView()
            }.opacity(0)
            HStack {
                if let imageURL = feed.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 30, height: 30)
                } else {
                    SVGView(contentsOf: Bundle.main.url(forResource: "rss-logo", withExtension: "svg")!)
                        .frame(width: 30, height: 30)
                }
                VStack(alignment: .leading) {
                    Text(feed.title).font(.headline)
                    if let description = feed.description {
                        Text(description).font(.subheadline)
                    }
                }
            }
        }
    }
}
