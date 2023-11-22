//
//  Movie.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 14/11/23.
//

import Foundation
import SwiftData

struct Movie: Identifiable, Codable {
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

struct Result: Codable, Identifiable, Hashable {
    let id: Int
    let original_title: String
    let poster_path: String?
    let release_date: String
}

struct Results: Codable {
    let page: Int
    let results: [Result]
}


