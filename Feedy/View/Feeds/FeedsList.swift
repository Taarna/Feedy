//
//  ContentView.swift
//  Feedy
//
//  Created by Ivana Rast on 15.05.2024.
//

import SwiftUI
import SwiftData
import AlertToast

struct FeedsList: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var dataModel: DataModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @Query(filter: #Predicate<Feed>  { !$0.isFavorite })
    private var feeds: [Feed]
    
    @Query(filter: #Predicate<Feed>  { $0.isFavorite })
    private var favoriteFeeds: [Feed]
    
    @State private var isAddFeedViewPresented = false
    @State private var isToastPresented = false
    @State private var toastMessage = ""
    
    var body: some View {
        NavigationSplitView {
            List {
                if (favoriteFeeds.count > 0) {
                    Section("Favorites") {
                        ForEach(favoriteFeeds, id: \.id) { favoriteFeed in
                            FeedCell(feed: favoriteFeed)
                        }
                        .onDelete(perform: deleteFavoriteFeeds)
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
        .toast(isPresenting: $isToastPresented){
            AlertToast(displayMode: .hud, type: .regular, title: toastMessage)
        }
        .sheet(isPresented: $isAddFeedViewPresented) {
            AddFeed(isPresented: $isAddFeedViewPresented) { feedURL in
                Task {
                    await addFeed(url: feedURL)
                }
            }
        }
        .onReceive(networkMonitor.$isConnected, perform: { isConnected in
            if !isConnected {
                toastMessage = "You are offline. Please check your internet connection."
                isToastPresented = true
            }
        })
        
    }
    
    @MainActor
    private func addFeed(url: String) async {
        do {
            try await dataModel.add(feedUrl: url, into: modelContext)
        } catch FeedyError.incorrectURL {
            toastMessage = ErrorMessage.incorrectURL.rawValue
            isToastPresented = true
        } catch {
            toastMessage = ErrorMessage.unknownError.rawValue
            isToastPresented = true
        }
    }
    
    private func deleteFeeds(offsets: IndexSet) {
        for index in offsets {
            dataModel.remove(feed: feeds[index], fromContext: modelContext)
        }
    }
    
    private func deleteFavoriteFeeds(offsets: IndexSet) {
        for index in offsets {
            dataModel.remove(feed: favoriteFeeds[index], fromContext: modelContext)
        }
    }
}
