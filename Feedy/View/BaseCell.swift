//
//  BaseCell.swift
//  Feedy
//
//  Created by Ivana Rast on 18.05.2024.
//

import SwiftUI
import SVGView

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
                SVGView(contentsOf: logoURL).frame(width: imageSize, height: imageSize)
            }
            VStack(alignment: .leading) {
                Text(title).font(.headline)
                if let details {
                    Text(details).font(.footnote).lineLimit(2)
                }
            }
        }
    }
}
