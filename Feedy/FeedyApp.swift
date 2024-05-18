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
    @State private var dataModel: DataModel
    
    init() {
//        let localStorage = LocalFeedStorage(with: UserDefaults.standard)
        let remoteService = RemoteFeedService()
        self.dataModel = DataModel(with: remoteService)
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Feed.self,
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
            FeedsList().environment(dataModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
