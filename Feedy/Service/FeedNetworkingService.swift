//
//  FeedNetworkingService.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024.
//

import Foundation

protocol FeedNetworkingService {
    func getFeed(with url: URL) async -> Result<Feed, Error>
}
