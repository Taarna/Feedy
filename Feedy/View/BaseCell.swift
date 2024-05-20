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
    
    private let logoURL = Bundle.main.url(forResource: "rss-logo", withExtension: "svg")!
    private let imageSize = 70.0
    
    var body: some View {
        HStack {
            if let imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
            } else {
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .foregroundColor(Color.accentColor)
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
