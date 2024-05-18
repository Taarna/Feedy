//
//  BaseCell.swift
//  Feedy
//
//  Created by Ivana Rast on 18.05.2024..
//

import SwiftUI
import SVGView

struct BaseCell: View {
    let imageURL: URL?
    let title: String
    let details: String?
    
    private let logoURL = Bundle.main.url(forResource: "rss-logo", withExtension: "svg")!
    private let imageSize = 80.0
    
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
                Text(title).font(.headline).lineLimit(2)
                if let details {
                    Text(details).font(.footnote).lineLimit(2)
                }
            }
        }
        .padding()
    }
}

#Preview {
    BaseCell(
        imageURL: URL(string: "https://images.megapixl.com/6343/63436347.jpg"),
        title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    )
}
