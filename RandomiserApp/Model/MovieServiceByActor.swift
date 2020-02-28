//
//  MovieServiceByActor.swift
//  RandomiserApp
//
//  Created by Bailee Devey on 25/11/19.
//  Copyright © 2019 Bailee Devey. All rights reserved.
//

import Foundation

class MovieServiceByActor {
    let actor: String
    let baseUrl: URL?
    
    init(ACTOR: String) {
        var formattedActor = ACTOR.replacingOccurrences(of: " ", with: "+")
        formattedActor = formattedActor.replacingOccurrences(of: "\u{2019}", with: "%27")
        self.actor = formattedActor
        baseUrl = URL(string: "https://randomiser-final.appspot.com/actor?actor=\(formattedActor.uppercased())")
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
