//
//  HomeViewModel.swift
//  Movies App
//
//  Created by OmarMansour on 2/1/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    let api = MoviesAPI()
    var apiKey = StaticVariables.apiKey
    var nowPlayingMovies = PublishSubject<Movies>()
    var popularMovies = PublishSubject<Movies>()
    var topRatedMovies = PublishSubject<Movies>()
    
    func getNowPlayingMovies(page: Int){
        api.getNowPlayingMovies(api_key: apiKey, page: "\(page)") { (result) in
            switch result{
            case .success(let nowPlayingMovies):
                guard let nowPlayingMovies = nowPlayingMovies else {return}
                self.nowPlayingMovies.onNext(nowPlayingMovies)
            case .failure(let error):
                print(error.message!)
            }
        }
    }
    
    func getPopularMovies(page: Int){
        api.getPopularMovies(api_key: apiKey, page: "\(page)") { (result) in
            switch result{
            case.success(let popularMovies):
                guard let popularMovies = popularMovies else {return}
                self.popularMovies.onNext(popularMovies)
            case .failure(let error):
                print(error.message as Any)
            }
        }
    }
        
    func getTopRatedMovies(page: Int){
        api.getTopRatedMovies(api_key: apiKey, page: "\(page)") { (result) in
            switch result{
            case.success(let topRatedMovies):
                guard let topRatedMovies = topRatedMovies else {return}
                self.topRatedMovies.onNext(topRatedMovies)
            case .failure(let error):
                print(error.message as Any)
            }
        }
    }
    
}
