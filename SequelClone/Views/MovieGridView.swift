//
//  MovieGridView.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 15/11/23.
//

import SwiftUI

struct MovieGridView: View {
    @State private var gridLayout: [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    var movies: [Movie]
    
    var body: some View { 
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: gridLayout, spacing: 10){
                ForEach(movies.indices, id: \.self){ index in
                        VStack(alignment: .leading){
                            MovieGridItemView(movie: movies[index])
                            Text(movies[index].originalTitle)
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .bold()
                            Text(movies[index].releaseDate)
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.leading)
                        }
                        .accessibilityElement(children: .combine)
                }
            }
            .padding(.horizontal)
        }
    }
}

//#Preview {
//    MovieGridView(movies: [])
//}
