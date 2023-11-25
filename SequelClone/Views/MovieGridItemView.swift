//
//  MovieGridItemView.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 15/11/23.
//

import SwiftUI
import SwiftData

struct MovieGridItemView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var movies: [Movie]
    @State private var watched = 1
    var movie: Movie
    
    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            ZStack(alignment: .bottomLeading) {
                let path = movie.posterPath ?? ""
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(path)")) { image in
                    image.resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 0.2)
                        )
                } placeholder: {
                    Image("no_poster")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 0.2)
                        )
                }
                .contextMenu {
                    Section {
                        Picker("", selection: $watched) {
                            Label("Watchlist", systemImage: "sparkles").tag(1)
                            
                            Label("Watched", systemImage: "checkmark.circle").tag(2)
                        }
                        .onChange(of: watched) { oldValue, newValue in
                            switch newValue {
                            case 1:
                                if(movie.watched == 2){
                                    movie.watched = 1
                                    watched = 1
                                    modelContext.insert(movie)
                                }
                            case 2:
                                if(movie.watched == 1){
                                    movie.watched = 2
                                    watched = 2
                                    modelContext.insert(movie)
                                }
                            default:
                                break
                            }
                        }
                    }
                    
                    Divider()
                    Button(role: .destructive) {
                        modelContext.delete(movie)
                    } label: {
                        Label("Remove...", systemImage: "trash")
                    }
                }
                
                if(movie.rating > 0) {
                    VStack {
                        HStack {
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10, height: 10)
                            Text("\(movie.rating)")
                                .bold()
                                .font(.caption2)
                        }
                        .foregroundColor(.black)
                        .padding(5)
                        .background(Capsule().foregroundColor(.white))
                    }
                    .padding(10)
                }
            }
        }
        .task {
            if movie.watched == 1 {
                watched = 1
            } else if movie.watched == 2 {
                watched = 2
            } else {
                watched = 0
            }
        }
    }
}

//#Preview {
//    MovieGridItemView(movie: Result(id: 0, original_title: "", poster_path: "", release_date: ""))
//        .frame(width: 200, height: 200, alignment: .center)
//}
