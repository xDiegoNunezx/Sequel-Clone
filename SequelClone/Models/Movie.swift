//
//  Movie.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 14/11/23.
//

import Foundation
import SwiftData

@Model
final class Movie {
    @Attribute(.unique) var id: Int
    var originalTitle: String
    var posterPath: String?
    var releaseDate: String
    var watched: Int
    var rating: Float
    
    init(id: Int, originalTitle: String, posterPath: String?, releaseDate: String, watched: Int, rating: Float) {
        self.id = id
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.watched = watched
        self.rating = rating
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        // Convierte la cadena a objeto Date
        if let fechaObjeto = dateFormatter.date(from: releaseDate) {
            // Configura otro DateFormatter para formatear la fecha en el nuevo formato
            let nuevoDateFormatter = DateFormatter()
            nuevoDateFormatter.dateFormat = "dd MMMM yyyy"
            
            // Formatea la fecha en el nuevo formato
            let fechaFormateada = nuevoDateFormatter.string(from: fechaObjeto)
            
            self.releaseDate = fechaFormateada
        } else {
            self.releaseDate = releaseDate
        }
    }
}

struct MovieResult: Identifiable, Codable {
    let id: Int
    let backdrop_path: String?
    let genres: [Genre]
    let original_title: String
    let poster_path: String?
    let release_date: String
}

struct Genre: Identifiable, Codable {
    let id: Int
    let name: String
}

struct Result: Identifiable, Hashable, Codable {
    let id: Int
    let original_title: String
    let poster_path: String?
    let release_date: String
}

struct Results: Codable {
    let page: Int
    let results: [Result]
}
