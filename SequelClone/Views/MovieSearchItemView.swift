//
//  MovieSearchItemView.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 18/11/23.
//

import SwiftUI
import SwiftData

struct MovieSearchItemView: View {
    var movieResult: Result
    @State var movie: Movie = Movie(id: 0, originalTitle: "", posterPath: "", releaseDate: "", watched: 0, rating: 0)
    @Environment(\.modelContext) private var modelContext
    
    @Query private var movies: [Movie]
    
    @State private var navigateToDetail = false
    @State private var watched = 0
    
    var body: some View {
        ZStack{
            NavigationLink(destination: MovieDetailView(movie: movie), isActive: $navigateToDetail) {
                EmptyView()
            }
            HStack {
                HStack{
                    let path = movieResult.poster_path ?? ""
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(path)")){
                        image in
                        image.resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 0.2)
                            )
                            .frame(height: 130)
                    } placeholder: {
                        Image("no_poster")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 0.2)
                            )

                            .frame(height: 130)
                    }

                    VStack(alignment: .leading) {
                        if(movie.watched == 1){
                            Text("WATCHLIST")
                                .foregroundStyle(.redPrimary)
                                .font(.caption)
                        } else if(movie.watched == 2){
                            Text("WATCHED")
                                .foregroundStyle(.redPrimary)
                                .font(.caption)
                        }
                        Text(movieResult.original_title)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Text(movieResult.release_date)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.leading)
                            
                    }
                }
                .accessibilityElement(children: .combine)
                
                Spacer()
                
                if(movie.watched == 0){
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white)
                        .padding(5)
                        .shadow(radius: 5)
                        .bold()
                        .onTapGesture {
                            print(movieResult.original_title)
                            movie.watched = 1
                            modelContext.insert(movie)
                        }
                        .background(Circle().foregroundStyle(.redPrimary))
                        .padding()
                        .accessibilityRemoveTraits(.isImage)
                        .accessibilityLabel("Add to watchlist button")
                } else {
                    Menu {
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
                                        modelContext.insert(movie)
                                        watched = 1
                                    }
                                case 2:
                                    if(movie.watched == 1){
                                        movie.watched = 2
                                        modelContext.insert(movie)
                                        watched = 2
                                    }
                                default:
                                    break
                                }
                                
                            }
                        }
                        Divider()
                        Button(role: .destructive) {
                            watched = 0
                            modelContext.delete(movie)
                            movie = Movie(id: movieResult.id, originalTitle: movieResult.original_title, posterPath: movieResult.poster_path, releaseDate: movieResult.release_date, watched: 0, rating: 0)
                        } label: {
                            Label("Remove...", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.foreground,.background)
                            .symbolRenderingMode(.palette)
                            .padding()
                    } 
                    .onTapGesture {
                        if movie.watched == 1 {
                            watched = 1
                        } else if movie.watched == 2 {
                            watched = 2
                        } else {
                            watched = 0
                        }
                    }
                }
            }.onTapGesture {
                navigateToDetail = true
            }
        }
        .task {
            let arrayMovie = movies.filter({ movie in
                movie.id == movieResult.id
            })
            
            if (!arrayMovie.isEmpty) {
                movie = arrayMovie[0]
            } else {
                movie = Movie(id: movieResult.id, originalTitle: movieResult.original_title, posterPath: movieResult.poster_path, releaseDate: movieResult.release_date, watched: 0, rating: 0)
            }
        }
    }
}
