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
    
    @Query(filter: #Predicate<Feed>  { !$0.isFavorite })
    private var feeds: [Feed]
    
    @Query(filter: #Predicate<Feed>  { $0.isFavorite })
    private var favoriteFeeds: [Feed]
    
    @State private var isAddFeedViewPresented = false
    
    var body: some View {
        NavigationSplitView {
            List {
                if(favoriteFeeds.count > 0) {
                    Section("Favorites") {
                        ForEach(favoriteFeeds, id: \.id) { favoriteFeed in
                            FeedCell(feed: favoriteFeed)
                        }
                        .onDelete(perform: deleteFeeds)
                    }
                }
                Section("") {
                    ForEach(feeds, id: \.id) { feed in
                        FeedCell(feed: feed)
                    }
                    .onDelete(perform: deleteFeeds)
                }
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
