//
//  ContentView.swift
//  Feedy
//
//  Created by Ivana Rast on 15.05.2024.
//

import SwiftUI
import SwiftData

struct FeedsList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var feeds: [Feed]
    @State private var isAddFeedViewPresented = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(feeds) { feed in
                    NavigationLink {
                        Text("\(feed.url)")
                    } label: {
                        Text(feed.url)
                    }
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
            AddFeed(isPresented: $isAddFeedViewPresented) { feedURL in
                add(feedUrl: feedURL)
            }
        }
    }

    private func add(feedUrl url: String) {
        withAnimation {
            let newFeed = Feed(url: url)
            modelContext.insert(newFeed)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(feeds[index])
            }
        }
    }
}

#Preview {
    FeedsList()
        .modelContainer(for: Feed.self, inMemory: true)
}
