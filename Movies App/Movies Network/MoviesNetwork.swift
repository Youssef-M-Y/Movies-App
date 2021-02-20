//
//  MoviesNetwork.swift
//  Movies App
//
//  Created by OmarMansour on 1/25/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation
import Alamofire

enum MoviesNetwork {
    case getLatestMovies(page: String)
    case getNowPlayingMovies(page: String)
    case getPopularMovies(page: String)
    case getTopRatedMovies(page: String)
    case getMovieDetails(movieId: Int)
    case getSearchMovies(page: String , movieName: String)
}

struct MoviesEndPoints {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let getLatestMovies = "movie/latest"
    static let getNowPlayingMovies = "movie/now_playing"
    static let getPopularMovies = "movie/popular"
    static let getTopRatedMovies = "movie/top_rated"
    static let getMovieDetails = "movie/"
    static let getSearchMovies = "search/movie"
}

// MARK:- Conforms to TargetType Protocol

extension MoviesNetwork: TargetType {
    
    var baseURL: String {
            return MoviesEndPoints.baseURL
    }
    
    var path: String {
        let api_key = StaticVariables.apiKey
        switch self {
        case .getLatestMovies(page: let page):
            return MoviesEndPoints.getLatestMovies + "?api_key=" + api_key + "&page=" + page
        case .getNowPlayingMovies(page: let page):
            return MoviesEndPoints.getNowPlayingMovies + "?api_key=" + api_key  + "&page=" + page
        case .getPopularMovies(page: let page):
            return MoviesEndPoints.getPopularMovies + "?api_key=" + api_key  + "&page=" + page
        case .getTopRatedMovies(page: let page):
            return MoviesEndPoints.getTopRatedMovies + "?api_key=" + api_key  + "&page=" + page
        case .getMovieDetails(movieId: let movieId):
            return MoviesEndPoints.getMovieDetails + "\(movieId)" + "?api_key=" + api_key
        case .getSearchMovies(page: let page, movieName: let movieName):
            return MoviesEndPoints.getSearchMovies + "?api_key=" + api_key  + "&page=" + page + "&query=" + movieName
        }
    }
    
    var method: HTTPMethods {
        return .get
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
