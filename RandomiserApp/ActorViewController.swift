//
//  ActorViewController.swift
//  RandomiserApp
//
//  Created by Bailee Devey on 25/11/19.
//  Copyright © 2019 Bailee Devey. All rights reserved.
//

import UIKit

class ActorViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UITextView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchMovie(_ sender: UIButton) {
        dismissKeyboard()
        retrieveMoviesByGenre()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func retrieveMoviesByGenre() {
        let movieService = MovieServiceByActor(ACTOR: textField.text!)
        movieService.getMovie { (currentMovie) in
            if let currentMovie = currentMovie {
                DispatchQueue.main.async {
                    if let title = currentMovie.title {
                        self.movieTitleLabel.text = "\(title)"
                    }
                    if let releaseDate = currentMovie.year {
                        self.movieYearLabel.text = "\(releaseDate)"
                    }
                    if let overview = currentMovie.plot {
                        self.movieOverviewLabel.text = "\(overview)"
                    }
                    if let image = currentMovie.imageUrl {
                        guard let url = URL(string: image) else { return }
                        URLSession.shared.dataTask(with: url) {
                            (data, response, error) in
                            guard let data = data else { return }
                            DispatchQueue.main.async {
                                self.movieImage.image = UIImage(data: data)
                            }
                        }.resume()
                    }
                }
            }
        }
    }
        
}
