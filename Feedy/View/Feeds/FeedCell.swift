//
//  FeedRow.swift
//  Feedy
//
//  Created by Ivana Rast on 17.05.2024.
//

import SwiftUI

struct FeedCell: View {
    @Environment(\.colorScheme) var colorScheme
    
    let feed: Feed
    
    @State private var isFavorite = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            NavigationLink(destination: FeedItemsList(feed: feed)) {
                EmptyView()
            }.opacity(0)
            VStack(alignment: .listRowSeparatorTrailing) {
                BaseCell(imageURL: feed.imageURL, title: feed.title, details: feed.details)
                Button(action: {
                    toggleFavorited()
                }) {
                    Image(systemName: feed.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(5.0)
            }
        }
    }
    
    private func toggleFavorited() {
        feed.isFavorite.toggle()
    }
}
