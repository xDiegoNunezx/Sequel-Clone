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
    
    //@EnvironmentObject private var movielists: MovieLists
    @Environment(\.modelContext) private var modelContext
    @State private var selection = 0
    @State private var showModal = false
    
    @Query(filter:#Predicate<Movie> { movie in movie.watched == 1})
    private var watchlist: [Movie]
    
    @Query(filter:#Predicate<Movie> { movie in movie.watched == 2})
    private var watched: [Movie]
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    ZStack{
                        NavigationLink(destination: EmptyView()) {
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
                        MovieGridView(movies: watchlist)
                    } else {
                        MovieGridView(movies: watched)
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
