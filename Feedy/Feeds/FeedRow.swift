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
            NavigationLink(destination: FeedItemsList(feed: feed)) {
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
                    let logoURL = Bundle.main.url(forResource: "rss-logo", withExtension: "svg")!
                    SVGView(contentsOf: logoURL).frame(width: 30, height: 30)
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
