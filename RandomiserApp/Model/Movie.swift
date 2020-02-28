//
//  Movie.swift
//  RandomiserApp
//
//  Created by Bailee Devey on 22/11/19.
//  Copyright © 2019 Bailee Devey. All rights reserved.
//

import Foundation

class Movie {
    let id: Int?
    let title: String?
    let year: String?
    let imageUrl: String?
    let plot: String?
    
    struct MovieKeys {
        static let id = "id"
        static let title = "title"
        static let year = "releaseDate"
        static let imageUrl = "posterPath"
        static let plot = "overView"
    }
    
    init(movieDictionary: [String : Any]) {
        id = movieDictionary[MovieKeys.id] as? Int
        title = movieDictionary[MovieKeys.title] as? String
        year = movieDictionary[MovieKeys.year] as? String
        imageUrl = movieDictionary[MovieKeys.imageUrl] as? String
        plot = movieDictionary[MovieKeys.plot] as? String
    }
}
