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
    var dataModel: DataModel
    
    init() {
        let localStorage = LocalFeedStorage(with: UserDefaults.standard)
        let remoteService = RemoteFeedService(with: localStorage)
        self.dataModel = DataModel(with: localStorage, remoteService: remoteService)
    }
    
    var body: some Scene {
        WindowGroup {
            FeedsList()
                .environmentObject(dataModel)
        }
    }
}
