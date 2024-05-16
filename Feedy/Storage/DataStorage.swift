//
//  DataStorage.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024.
//

import Foundation

protocol DataStorage {
    func set<T: Codable>(object: T, forKey: String) throws
    func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T?
}
