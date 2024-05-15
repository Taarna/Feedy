//
//  Feed.swift
//  Feedy
//
//  Created by Ivana Rast on 15.05.2024.
//

import SwiftData

@Model
final class Feed {
    var url: String
//    var title: String
//    var desc: String
//    var imageUrl: String
    
    init(url: String) {
        self.url = url
//        self.title = title
//        self.desc = desc
//        self.imageUrl = imageUrl
    }
}
