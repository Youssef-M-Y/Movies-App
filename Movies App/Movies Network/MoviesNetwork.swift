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
    case getLatestMovies
    case getNowPlayingMovies
    case getPopularMovies
    case getTopRatedMovies
    case getMovieDetails(movieId: Int)
}

struct MoviesEndPoints {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let getLatestMovies = "movie/latest"
    static let getNowPlayingMovies = "movie/now_playing"
    static let getPopularMovies = "movie/popular"
    static let getTopRatedMovies = "movie/top_rated"
    static let getMovieDetails = "movie/"
}

// MARK:- Conforms to TargetType Protocol

extension MoviesNetwork: TargetType {
    
    var baseURL: String {
            return MoviesEndPoints.baseURL
    }
    
    var path: String {
        let api_key = StaticVariables.apiKey
        switch self {
        case .getLatestMovies:
            return MoviesEndPoints.getLatestMovies + "?api_key=" + api_key
        case .getNowPlayingMovies:
            return MoviesEndPoints.getNowPlayingMovies + "?api_key=" + api_key
        case .getPopularMovies:
            return MoviesEndPoints.getPopularMovies + "?api_key=" + api_key
        case .getTopRatedMovies:
            return MoviesEndPoints.getTopRatedMovies + "?api_key=" + api_key
        case .getMovieDetails(movieId: let movieId):
            return MoviesEndPoints.getMovieDetails + "\(movieId)" + "?api_key=" + api_key
        }
    }
    
    var method: HTTPMethods {
        switch self {
        case .getLatestMovies:
            return .get
        case .getNowPlayingMovies:
            return .get
        case .getPopularMovies:
            return .get
        case .getTopRatedMovies:
            return .get
        case .getMovieDetails:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
