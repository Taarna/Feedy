//
//  BaseCell.swift
//  Feedy
//
//  Created by Ivana Rast on 18.05.2024.
//

import SwiftUI

struct BaseCell: View {
    let imageURL: URL?
    let title: String
    let details: String?
    
    private let imageSize = 70.0
    
    var body: some View {
        HStack {
            if let imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    PlaceholderImage()
                }
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
            } else {
                PlaceholderImage()
            }
            Spacer()
            VStack(alignment: .leading) {
                Text(title).font(.headline)
                if let details {
                    Text(details).font(.footnote).lineLimit(4)
                }
            }
        }
    }
}

struct PlaceholderImage: View {
    @Environment(\.colorScheme) var colorScheme
    
    private let imageSize = 70.0
    
    var body: some View {
        Image(systemName: "questionmark.square.dashed")
            .resizable()
            .frame(width: imageSize, height: imageSize)
            .aspectRatio(contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .foregroundColor(colorScheme == .light ? .black : .white)
    }
}
