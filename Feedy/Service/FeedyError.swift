//
//  FeedyError.swift
//  Feedy
//
//  Created by Ivana Rast on 20.05.2024.
//

import Foundation

enum FeedyError: Error {
    case incorrectURL
    case unknownError
}

extension FeedyError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .incorrectURL:
            return ErrorMessage.incorrectURL.rawValue
        case .unknownError:
            return ErrorMessage.unknownError.rawValue
        }
    }
}
