//
//  MovieLists.swift
//  SequelClone
//
//  Created by Diego Ignacio Nunez Hernandez on 19/11/23.
//

import Foundation
import SwiftData

class MovieLists: ObservableObject {
    @Published var watchlist = Set<Result>()
    @Published var watched = Set<Result>()
    @Published var ratings: [Int:Float] = [:]
}

@Model
final class MovieData {
    var watchlist: [Result]
    var watched: [Result]
    var ratings: [Int:Float]
    
    init(watchlist: [Result], watched: [Result], ratings: [Int : Float]) {
        self.watchlist = watchlist
        self.watched = watched
        self.ratings = ratings
    }
}
