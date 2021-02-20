//
//  MoviesAPI.swift
//  Movies App
//
//  Created by OmarMansour on 1/25/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation

protocol MoviesAPIProtocol {
    func getLatestMovies(api_key: String, page: String, completion: @escaping (Result<[LatestMovies]? , NetworkError>) -> Void)
    func getNowPlayingMovies(api_key: String, page: String, completion: @escaping (Result<Movies? , NetworkError>) -> Void)
    func getPopularMovies(api_key: String, page: String, completion: @escaping (Result<Movies? , NetworkError>) -> Void)
    func getTopRatedMovies(api_key: String, page: String, completion: @escaping(Result<Movies? , NetworkError>) -> Void)
    func getMovieDetails(movieId: Int , api_key: String, completion: @escaping(Result<Movie? , NetworkError>) -> Void)
    func getSearchMovies(api_key: String, movieName: String, page: String, completion: @escaping(Result<Movies? , NetworkError>) -> Void)
}

class MoviesAPI: MoviesAPIProtocol{
    
    func getLatestMovies(api_key: String, page: String, completion: @escaping (Result<[LatestMovies]?, NetworkError>) -> Void) {
        let alamofireNetwork = AlamoFireNetworking<[LatestMovies]>()
        let moviesNetwork = MoviesNetwork.getLatestMovies(page: page)
        
//        let queryParams = ["api_key": api_key]
        
        alamofireNetwork.makeRequest(baseUrl: moviesNetwork.baseURL, uri: moviesNetwork.path, method: moviesNetwork.method.rawValue, body: nil, headers: moviesNetwork.headers, queryParams: nil) { (result) in
            switch result{
            case .success(let response):
                guard let response = response?.body else {return}
                completion(.success(response as? [LatestMovies]))
            case .failure(let error):
                guard let error = error.body else {return}
                completion(.failure(error as! NetworkError))
            }
        }
    }
    
    func getNowPlayingMovies(api_key: String, page: String, completion: @escaping (Result<Movies? , NetworkError>) -> Void) {
        let alamofireNetwork = AlamoFireNetworking<Movies>()
        let moviesNetwork = MoviesNetwork.getNowPlayingMovies(page: page)
        
        //        let queryParams = ["api_key": api_key]
        
        alamofireNetwork.makeRequest(baseUrl: moviesNetwork.baseURL, uri: moviesNetwork.path, method: moviesNetwork.method.rawValue, body: nil, headers: moviesNetwork.headers, queryParams: nil) { (result) in
            switch result{
            case .success(let response):
                guard let response = response?.body else {return}
                completion(.success(response as? Movies))
            case .failure(let error):
                guard let error = error.body else {return}
                completion(.failure(error as! NetworkError))
            }
        }
    }
    
    func getPopularMovies(api_key: String, page: String, completion: @escaping (Result<Movies?, NetworkError>) -> Void) {
        let alamofireNetwork = AlamoFireNetworking<Movies>()
        let moviesNetwork = MoviesNetwork.getPopularMovies(page: page)
        
        //        let queryParams = ["api_key": api_key]
        
        alamofireNetwork.makeRequest(baseUrl: moviesNetwork.baseURL, uri: moviesNetwork.path, method: moviesNetwork.method.rawValue, body: nil, headers: moviesNetwork.headers, queryParams: nil) { (result) in
            switch result{
            case .success(let response):
                guard let response = response?.body else {return}
                completion(.success(response as? Movies))
            case .failure(let error):
                guard let error = error.body else {return}
                completion(.failure(error as! NetworkError))
            }
        }
    }
    
    func getTopRatedMovies(api_key: String, page: String, completion: @escaping (Result<Movies?, NetworkError>) -> Void) {
        let alamofireNetwork = AlamoFireNetworking<Movies>()
        let moviesNetwork = MoviesNetwork.getTopRatedMovies(page: page)
        
        //        let queryParams = ["api_key": api_key]
        
        alamofireNetwork.makeRequest(baseUrl: moviesNetwork.baseURL, uri: moviesNetwork.path, method: moviesNetwork.method.rawValue, body: nil, headers: moviesNetwork.headers, queryParams: nil) { (result) in
            switch result{
            case .success(let response):
                guard let response = response?.body else {return}
                completion(.success(response as? Movies))
            case .failure(let error):
                guard let error = error.body else {return}
                completion(.failure(error as! NetworkError))
            }
        }
    }
    
    func getMovieDetails(movieId: Int, api_key: String, completion: @escaping (Result<Movie?, NetworkError>) -> Void) {
        
        let alamofireNetwork = AlamoFireNetworking<Movie>()
        let moviesNetwork = MoviesNetwork.getMovieDetails(movieId: movieId)
        
        //        let queryParams = ["api_key": api_key]
        
        alamofireNetwork.makeRequest(baseUrl: moviesNetwork.baseURL, uri: moviesNetwork.path, method: moviesNetwork.method.rawValue, body: nil, headers: moviesNetwork.headers, queryParams: nil) { (result) in
            switch result{
            case .success(let response):
                guard let response = response?.body else {return}
                completion(.success(response as? Movie))
            case .failure(let error):
                guard let error = error.body else {return}
                completion(.failure(error as! NetworkError))
            }
        }
    }
    
    func getSearchMovies(api_key: String, movieName: String, page: String, completion: @escaping (Result<Movies?, NetworkError>) -> Void) {
        
        let alamofireNetwork = AlamoFireNetworking<Movies>()
        let moviesNetwork = MoviesNetwork.getSearchMovies(page: page, movieName: movieName)
        
        //        let queryParams = ["api_key": api_key]
        
        alamofireNetwork.makeRequest(baseUrl: moviesNetwork.baseURL, uri: moviesNetwork.path, method: moviesNetwork.method.rawValue, body: nil, headers: moviesNetwork.headers, queryParams: nil) { (result) in
            switch result{
            case .success(let response):
                guard let response = response?.body else {return}
                completion(.success(response as? Movies))
            case .failure(let error):
                guard let error = error.body else {return}
                completion(.failure(error as! NetworkError))
            }
        }

    }
    
}
