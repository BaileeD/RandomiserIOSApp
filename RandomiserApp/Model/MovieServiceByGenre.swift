//
//  MovieService.swift
//  RandomiserApp
//
//  Created by Bailee Devey on 23/11/19.
//  Copyright © 2019 Bailee Devey. All rights reserved.
//

import Foundation

class MovieServiceByGenre {
    let genre: String
    let baseUrl: URL?
    
    init(GENRE: String) {
        self.genre = GENRE
        baseUrl = URL(string: "https://randomiser-final.appspot.com/movie?genre=\(GENRE.uppercased())")
    }
    
    func getMovie(completion: @escaping (Movie?) -> Void) {
        let networkProcessor = NetworkProcessor(url: baseUrl!)
        networkProcessor.downloadJsonFromUrl({ (jsonDictionary) in
            if let  randomMovieDictionary = jsonDictionary {
                let randomMovie = Movie(movieDictionary: randomMovieDictionary)
                completion(randomMovie)
            } else {
                completion(nil)
            }
        })
    }
}
