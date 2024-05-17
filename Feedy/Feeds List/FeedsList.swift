//
//  ContentView.swift
//  Feedy
//
//  Created by Ivana Rast on 15.05.2024.
//

import SwiftUI

struct FeedsList: View {
    @State private var isAddFeedViewPresented = false
    
    private var model = FeedsListModel()

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(model.feeds) { feed in
                    FeedRow(feed: feed)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        isAddFeedViewPresented = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                
            }
        } detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $isAddFeedViewPresented, onDismiss: {
            
        }) {
            AddFeed(isPresented: $isAddFeedViewPresented) { feedUrl in
                addFeed(url: feedUrl)
            }
        }
    }
    
    private func addFeed(url: String) {
        Task {
            await model.add(feedUrl: url)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            model.remove(feed: model.feeds[index])
        }
    }
}

struct FeedItems: View {
    let feed: Feed
    
    var body: some View {
        VStack {
            Text("\(feed.url)")
        }
    }
}

#Preview {
    FeedsList()
}
