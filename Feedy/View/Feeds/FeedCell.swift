//
//  FeedRow.swift
//  Feedy
//
//  Created by Ivana Rast on 17.05.2024.
//

import SwiftUI
import SVGView

struct FeedCell: View {
    let feed: Feed
    
    var body: some View {
        ZStack(alignment: .leading) {
            NavigationLink(destination: FeedItemsList(feed: feed)) {
                EmptyView()
            }.opacity(0)
            BaseCell(imageURL: feed.imageURL, title: feed.title, details: feed.details)
        }
    }
}

#Preview {
    let feedItem = FeedItem(
        id: UUID(),
        title: "Lorem Ipsum is simply dummy text",
        details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        imageURL: URL(string: "https://images.megapixl.com/6343/63436347.jpg"),
        link: URL(string: "https://www.kodeco.com/45116545-kodeco-podcast-uikit-to-swiftui-v2-s2-e9"))
    let feed = Feed(
        id: UUID(),
        url:"https://www.kodeco.com/45116545-kodeco-podcast-uikit-to-swiftui-v2-s2-e9",
        title: "Lorem Ipsum is simply dummy text",
        details: "Lorem Ipsum is simply dummy text",
        imageURL: URL(string: "https://images.megapixl.com/6343/63436347.jpg"),
        items: [feedItem])
    return FeedItemCell(feedItem: feedItem)
}
