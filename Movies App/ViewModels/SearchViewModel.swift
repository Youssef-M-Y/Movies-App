//
//  SearchViewModel.swift
//  Movies App
//
//  Created by OmarMansour on 2/18/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel{
    let api = MoviesAPI()
    var apiKey = StaticVariables.apiKey
    var movies = PublishSubject<Movies>()
    var searchText = BehaviorRelay<String>(value: "")
    
    func getMovies(page: String){
        let movieName = searchText.value
        api.getSearchMovies(api_key: apiKey, movieName: movieName, page: page) { (result) in
            switch result{
            case .success(let movies):
                guard let movies = movies else{return}
                self.movies.onNext(movies)
            case .failure(let error):
                print(error.message!)
            }
        }
    }
}
