//
//  SearchView.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 15/11/23.
//

import SwiftUI
struct SearchView: View {
    @StateObject var movies = SequelViewModel()
    @Binding var searchText: String
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 20){
                Text("Top Results")
                    .font(.footnote)
                    .bold()
                Text("Movies")
                    .font(.footnote)
                    .padding(9)
                    .foregroundStyle(.white)
                    .background(
                        Capsule().foregroundColor(.redPrimary)
                    )
                    .bold()
                Text("Series")
                    .font(.footnote)
                    .bold()
                Text("Games")
                    .font(.footnote)
                    .bold()
                Text("Books")
                    .font(.footnote)
                    .bold()
            }
            Spacer()
            List {
                ForEach(movies.dataMovies){ item in
                    MovieSearchItemView(movie: item)
                }
            }
            .listStyle(PlainListStyle())
            .listStyle(.inset)
            .task {
               await movies.fetchSearch(movie: searchText)
            }
            .onChange(of: searchText) { _,_ in
                Task {
                    await movies.fetchSearch(movie: searchText)
                }
            }
        }
        
    }
}
//
//#Preview {
//    SearchView(movies: SequelViewModel(), searchText: "Hunger Games")
//}
