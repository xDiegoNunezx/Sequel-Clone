//
//  MoviesView.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 15/11/23.
//

import SwiftUI
import SwiftData

struct MoviesView: View {
    init() {
        UISegmentedControl.appearance()
            .selectedSegmentTintColor = .red
        
        UISegmentedControl.appearance()
            .setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    //@Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var movielists: MovieLists
    @State private var selection = 0
    @State private var showModal = false
    //@Query private var movieData: [MovieData]
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    ZStack{
                        NavigationLink(destination: HomeView()) {
                            HStack {
                                Image(systemName: "books.vertical.fill")
                                Text("Your collections")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .foregroundStyle(.foreground)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    Divider()
                    HStack(spacing:160) {
                        Picker("Watchlist or Watched?", selection: $selection) {
                            Text("Watchlist")
                                .background(Capsule().foregroundColor(.white))
                                .tag(0)
                            Text("Watched").tag(1)
                        }
                        .pickerStyle(.segmented)
                        Menu {
                            Button("Opción 1") {}
                            Button("Opción 2") {}
                        } label: {
                            Image(systemName: "ellipsis.circle.fill")
                                .font(.title)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.redPrimary,.back)
                        }
                    }
                    .padding(.horizontal)
                    
                    if(selection == 0){
                        MovieGridView(movies: Array(movielists.watchlist))
                    } else {
                        MovieGridView(movies: Array(movielists.watched))
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showModal.toggle()
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.white)
                                .padding(25)
                                .shadow(radius: 5)
                                .bold()
                        }
                        .background(Circle().foregroundStyle(.redPrimary))
                        .padding()
                        .offset(x: 0, y: 10)
                        .fullScreenCover(isPresented: $showModal) {
                            ModalSearchView(isPresented: $showModal)
                        }
                    }
                }
                .navigationTitle("Movies")
            }
        }
        .task {
//            movielists.watchlist = Set(movieData.watchlist)
//            movielists.watched = Set(movieData.watched)
        }
    }
}

struct ModalSearchView: View {
    @Binding var isPresented: Bool
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            if(searchText.isEmpty) {
                Text("):")
            } else {
                SearchView(searchText: $searchText)
            }
        }
        .searchable(text: $searchText, isPresented: $isPresented, prompt: "Title, Actor, Director and More")
    }
}

#Preview {
    MoviesView()
}
