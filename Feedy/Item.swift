//
//  Item.swift
//  Feedy
//
//  Created by Ivana Rast on 15.05.2024..
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
