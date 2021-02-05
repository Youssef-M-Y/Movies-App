//
//  MovieDetailsViewModel.swift
//  Movies App
//
//  Created by OmarMansour on 2/4/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailsViewModel{
    let api = MoviesAPI()
    var apiKey = StaticVariables.apiKey
    var movie = PublishSubject<Movie>()
    
    func getMovieDetails(movieId: Int){
        api.getMovieDetails(movieId: movieId, api_key: apiKey) { (result) in
            switch result{
            case .success(let movie):
                guard let movie = movie else {return}
                self.movie.onNext(movie)
            case .failure(let error):
                print(error.message as Any)
            }
        }
    }
}
