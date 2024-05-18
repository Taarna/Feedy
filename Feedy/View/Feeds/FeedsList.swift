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
    @Environment(DataModel.self) private var dataModel
    
    @Query private var feeds: [Feed]
    
    @State private var isAddFeedViewPresented = false
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(feeds) { feed in
                    FeedCell(feed: feed)
                }
                .onDelete(perform: deleteFeeds)
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
                addFeed(withURL: feedURL)
            }
        }
    }
    
    private func addFeed(withURL url: String) {
        Task {
            await dataModel.add(feedUrl: url, into: modelContext)
        }
    }
    
    private func deleteFeeds(offsets: IndexSet) {
        for index in offsets {
            dataModel.remove(feed: feeds[index], fromContext: modelContext)
        }
    }
}
