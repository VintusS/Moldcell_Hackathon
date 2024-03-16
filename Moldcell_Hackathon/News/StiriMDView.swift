//
//  StiriMDView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI

struct StiriMDView: View {
    let articles = loadStiriMDArticles()

    var body: some View {
        List(articles, id: \.Article) { article in
            VStack(alignment: .leading) {
                Text(article.Title)
                    .font(.headline)
                
                Divider()
                
                Text(article.Subtitle)
                    .font(.subheadline)
                    .padding(.bottom)
                
                if let imageURL = URL(string: article.Image) {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.bottom)
                }
                Text(article.Description)
                    .font(.subheadline)
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    StiriMDView()
}
