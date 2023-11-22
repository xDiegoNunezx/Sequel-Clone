//
//  MovieGridItemView.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 15/11/23.
//

import SwiftUI
import SwiftData

struct MovieGridItemView: View {
    @EnvironmentObject var movielists: MovieLists
    //@Environment(\.modelContext) private var modelContext
    @State private var watched = 1
    //@Query private var movieData: MovieData
    var movie: Result
    
    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            ZStack(alignment: .bottomLeading) {
                let path = movie.poster_path ?? ""
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
                                if(movielists.watched.contains(movie)){
                                    movielists.watched.remove(movie)
                                    movielists.watchlist.insert(movie)
                                    watched = 1
                                    
//                                    movieData.watchlist = Array(movielists.watchlist)
//                                    movieData.watched = Array(movielists.watched)
//                                    modelContext.insert(movieData)
                                }
                            case 2:
                                if(movielists.watchlist.contains(movie)){
                                    movielists.watchlist.remove(movie)
                                    movielists.watched.insert(movie)
                                    watched = 2
                                    
//                                    movieData.watchlist = Array(movielists.watchlist)
//                                    movieData.watched = Array(movielists.watched)
//                                    modelContext.insert(movieData)
                                }
                            default:
                                break
                            }
                        }
                    }
                    
                    Divider()
                    Button(role: .destructive) {
                        if(movielists.watched.contains(movie)){
                            movielists.watched.remove(movie)
                        } else if(movielists.watchlist.contains(movie)) {
                            movielists.watchlist.remove(movie)
                        }
                        
//                        movieData.watchlist = Array(movielists.watchlist)
//                        movieData.watched = Array(movielists.watched)
//                        modelContext.insert(movieData)
                    } label: {
                        Label("Remove...", systemImage: "trash")
                    }
                }
                
                if(movielists.ratings[movie.id] ?? 0 > 0) {
                    VStack {
                        HStack {
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10, height: 10)
                            Text("\(movielists.ratings[movie.id] ?? 0)")
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
            if movielists.watchlist.contains(movie) {
                watched = 1
            } else if movielists.watched.contains(movie) {
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
