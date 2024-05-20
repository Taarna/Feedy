//
//  FeedyApp.swift
//  Feedy
//
//  Created by Ivana Rast on 15.05.2024.
//

import SwiftUI
import SwiftData

@main
struct FeedyApp: App {
    @StateObject private var dataModel: DataModel
    @StateObject private var networkMonitor: NetworkMonitor
    
    init() {
        let remoteService = RemoteFeedService()
        _dataModel = StateObject(wrappedValue: DataModel(with: remoteService))
        _networkMonitor = StateObject(wrappedValue: NetworkMonitor())
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Feed.self,
            FeedItem.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            FeedsList()
                .environmentObject(dataModel)
                .environmentObject(networkMonitor)
        }
        .modelContainer(sharedModelContainer)
    }
}
