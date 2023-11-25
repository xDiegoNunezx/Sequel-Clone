//
//  SequelViewModel.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 15/11/23.
//

import Foundation

@MainActor
class SequelViewModel: ObservableObject {
    @Published var dataMovies : [Result] = []
    @Published var title = ""
    @Published var movieId = 0
    @Published var show = false
    @Published var movieResult = MovieResult(id: 0, backdrop_path: "", genres: [], original_title: "", poster_path: "", release_date: "")

    func fetchSearch(movie: String) async {
        do{
            let urlString = "https://api.themoviedb.org/3/search/movie?api_key=377194c2d0bd914cf189560a3f658f97&language=en-US&query=\(movie)&page=1&include_adult=false"
            
            guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") else { return }
            
            let (data, _) = try await URLSession.shared.data(from: url)
    
            let json = try JSONDecoder().decode(Results.self, from: data)
            
            self.dataMovies = json.results
            
            print(json.results)
        }catch let error as NSError {
            print("Error en la api: ", error.localizedDescription)
        }
    }
    
    func fetchMovie(id: Int) async {
        do{
            let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=377194c2d0bd914cf189560a3f658f97&movie_id=502416&language=en-US"
            
            guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") else { return }
            
            print(url)
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            print(data)
            
            let json = try JSONDecoder().decode(MovieResult.self, from: data)
    
            self.movieResult = json
            
            print(json)
            
        }catch let error as NSError {
            print("Error en la apii: ", error.localizedDescription)
        }
    }
    
    func sendItem(item: Result){
        title = item.original_title
        movieId = item.id
        show.toggle()
    }
}
