//
//  LatestMovies.swift
//  Movies App
//
//  Created by OmarMansour on 1/25/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation

// MARK: - Gate
struct LatestMovies: Codable {
    let adult: Bool
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Int
    let posterPath: String
    let releaseDate: String
    let revenue, runtime: Int
    let status, tagline, title: String
    let video: Bool
    let voteAverage, voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
