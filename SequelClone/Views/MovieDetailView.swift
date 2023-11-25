//
//  MovieDetailView.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 15/11/23.
//

import SwiftUI

struct MovieDetailView: View {
    //@EnvironmentObject var movielists: MovieLists
    @StateObject private var movieModel = SequelViewModel()
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    @State private var watched = 0
    @State var movie: Movie
    
    var body: some View {
        ScrollView {
            ZStack {
                GeometryReader { geometry in
                    let path = movieModel.movieResult.backdrop_path ?? ""
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
                    let path = movieModel.movieResult.poster_path ?? ""
                    //let path = movie.posterPath ?? ""
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
                    
                    Text(movieModel.movieResult.original_title)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.top)
                        .padding(.horizontal)
                    
                    Text("\(movieModel.movieResult.release_date)")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .padding(.bottom,80)
                    
                    Button(action: {
                        if(movie.watched == 0){
                            movie.watched = 1
                            modelContext.insert(movie)
                        }
                    }, label: {
                        if(movie.watched == 1){
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
                                                //modelContext.insert(movie)
                                                watched = 1
                                                print(movie.originalTitle)
                                            }
                                        case 2:
                                            if(movie.watched == 1){
                                                movie.watched = 2
                                                //modelContext.insert(movie)
                                                watched = 2
                                                print(movie.originalTitle)
                                            }
                                        default:
                                            break
                                        }
                                        
                                    }
                                }
                                Divider()
                                Button(role: .destructive) {
                                    movie.watched = 0
                                    //modelContext.delete(movie)
                                    //movie = Movie(id: movieModel.movieResult.id, originalTitle: movieModel.movieResult.original_title, posterPath: movieModel.movieResult.poster_path, releaseDate: movieModel.movieResult.release_date, watched: 0, rating: 0)
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
                                if movie.watched == 1 {
                                    watched = 1
                                } else if movie.watched == 2 {
                                    watched = 2
                                } else {
                                    watched = 0
                                }
                            }
                            .padding()
                        } else if(movie.watched == 2) {
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
                                                //modelContext.insert(movie)
                                                watched = 1
                                                print(movie.originalTitle)
                                            }
                                        case 2:
                                            if(movie.watched == 1){
                                                movie.watched = 2
                                                //modelContext.insert(movie)
                                                watched = 2
                                                print(movie.originalTitle)
                                            }
                                        default:
                                            break
                                        }
                                        
                                    }
                                }
                                Divider()
                                Button(role: .destructive) {
                                    movie.watched = 0
                                    //modelContext.delete(movie)
                                    //movie = Movie(id: movieModel.movieResult.id, originalTitle: movieModel.movieResult.original_title, posterPath: movieModel.movieResult.poster_path, releaseDate: movieModel.movieResult.release_date, watched: 0, rating: 0)
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
                                if movie.watched == 1 {
                                    watched = 1
                                } else if movie.watched == 2 {
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
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movieModel.movieResult.backdrop_path ?? "")"), content: { image in
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
        .navigationBarItems(leading: MyBackButton(movie: movie))
        .task {
            await movieModel.fetchMovie(id: movie.id)         
            
        }
    }
}

struct MyBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    var movie: Movie
    
    var body: some View {
        Button(action: {
            if(movie.watched != 0) {modelContext.insert(movie)}
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left.circle.fill")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
        }
        .accessibilityLabel("Go back")
    }
}

//#Preview {
//    MovieDetailView()
//}
