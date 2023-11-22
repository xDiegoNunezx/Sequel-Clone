//
//  MovieDetailView.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 15/11/23.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var movielists: MovieLists
    @StateObject private var movieModel = SequelViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State private var watched = 0
    var movie: Result
    
    var body: some View {
        ScrollView {
            ZStack {
                GeometryReader { geometry in
                    let path = movieModel.movie.backdrop_path ?? ""
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(path)")){image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: max(300, 300 + geometry.frame(in: .global).minY))
                            .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY : 0)
                    } placeholder: {
                        if(colorScheme == .dark){
                            Color(.black)
                        } else {
                            Color(.white)
                        }
                    }
                }
                .frame(height: 700)
                
                VStack {
                    let path = movieModel.movie.poster_path ?? ""
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(path)")) { image in
                        image.resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 0.2)
                            )
                            .frame(height: 250)
                            .padding()
                    } placeholder: {
                        Image("no_poster")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 0.2)
                            )
                            .frame(height: 250)
                            .padding()
                    }
                    
                    Text(movieModel.movie.original_title)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.top)
                        .padding(.horizontal)
                    
                    Text("\(movieModel.movie.release_date)")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .padding(.bottom,80)
                    
                    Button(action: {
                        if(!movielists.watchlist.contains(movie) && !movielists.watched.contains(movie)){
                            movielists.watchlist.insert(movie)
                        }
                    }, label: {
                        if(movielists.watchlist.contains(movie)){
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
                                HStack(spacing: 25){
                                    Image(systemName: "sparkles")
                                        .foregroundStyle(.black)
                                    Text("Watchlist")
                                        .foregroundStyle(.black)
                                        .bold()
                                    Image(systemName: "ellipsis")
                                        .foregroundStyle(.black)
                                }
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
                            .padding()
                        } else if(movielists.watched.contains(movie)) {
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
                                HStack(spacing: 25){
                                    Image(systemName: "checkmark.circle")
                                        .foregroundStyle(.black)
                                    Text("Watched")
                                        .foregroundStyle(.black)
                                        .bold()
                                    Image(systemName: "ellipsis")
                                        .foregroundStyle(.black)
                                }
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
                            .padding()
                        } else {
                            HStack{
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(.black)
                                Text("Add Movie")
                                    .foregroundStyle(.black)
                                    .bold()
                            }
                            .padding()
                        }
                    })
                    .background(
                        Capsule().foregroundStyle(.white.opacity(0.8))
                    )
                }
            }
        }
        .background(
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movieModel.movie.backdrop_path ?? "")"), content: { image in
                image.resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .blur(radius: 50)
                    .offset(y: 120)
            }, placeholder: {
                Image("no_poster")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .blur(radius: 50)
                    .offset(y: 120)
            })
        )
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: MyBackButton())
        .task {
            await movieModel.fetchMovie(id: movie.id)
        }
    }
}

struct MyBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left.circle.fill")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
        }
    }
}

//#Preview {
//    MovieDetailView()
//}
