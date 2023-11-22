//
//  MovieSearchItemView.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 18/11/23.
//

import SwiftUI

struct MovieSearchItemView: View {
    var movie: Result
    @EnvironmentObject var movielists: MovieLists
    @State private var navigateToDetail = false
    @State private var watched = 0
    var body: some View {
        ZStack{
            NavigationLink(destination: MovieDetailView(movie: movie), isActive: $navigateToDetail) {
                EmptyView()
            }
            HStack {
                let path = movie.poster_path ?? ""
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
                    if(movielists.watchlist.contains(movie)){
                        Text("WATCHLIST")
                            .foregroundStyle(.redPrimary)
                            .font(.caption)
                    } else if(movielists.watched.contains(movie)){
                        Text("WATCHED")
                            .foregroundStyle(.redPrimary)
                            .font(.caption)
                    }
                    Text(movie.original_title)
                        .bold()
                        .multilineTextAlignment(.leading)
                    Text(movie.release_date)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                if(!movielists.watchlist.contains(movie) && !movielists.watched.contains(movie)){
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white)
                        .padding(5)
                        .shadow(radius: 5)
                        .bold()
                        .onTapGesture {
                            print(movie.original_title)
                            movielists.watchlist.insert(movie)
                            movielists.ratings[movie.id] = 0
                        }
                        .background(Circle().foregroundStyle(.redPrimary))
                        .padding()
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
                                    if(movielists.watched.contains(movie)){
                                        movielists.watched.remove(movie)
                                        movielists.watchlist.insert(movie)
                                        watched = 1
                                    }
                                case 2:
                                    if(movielists.watchlist.contains(movie)){
                                        movielists.watchlist.remove(movie)
                                        movielists.watched.insert(movie)
                                        watched = 2
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
                        if movielists.watchlist.contains(movie) {
                            watched = 1
                        } else if movielists.watched.contains(movie) {
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

    }
}
