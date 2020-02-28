//
//  MovieViewController.swift
//  RandomiserApp
//
//  Created by Bailee Devey on 23/11/19.
//  Copyright © 2019 Bailee Devey. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var movieOverviewLabel: UITextView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet var textField: UITextField!
    
    let pickerData: [String] = ["Action", "Adventure",
        "Animation", "Comedy", "Crime", "Documentary", "Drama",
        "Family", "Fantasy", "History", "Horror", "Music",
        "Mystery", "Romance", "Science_Fiction", "TV_Movie",
        "Thriller", "War", "Western"]
    
    @IBAction func searchMovie(_ sender: UIButton) {
        dismissKeyboard()
        retrieveMoviesByGenre()
    }
    
    func retrieveMoviesByGenre() {
        let movieService = MovieServiceByGenre(GENRE: textField.text!)
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
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let genrePicker =  UIPickerView()
        genrePicker.delegate = self
        textField.inputView = genrePicker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = pickerData[row]
    }

}
