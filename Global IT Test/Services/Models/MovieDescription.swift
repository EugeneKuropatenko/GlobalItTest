//
//  MovieDescription.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/7/19.
//  Copyright © 2019 home. All rights reserved.
//

/// Movie description
public class MovieDescription: Decodable {
    /// Movie identifier
    public let id: Int
    public let voteCount: Int
    public let video: Bool
    public let voteAverage: Double
    public let title: String
    public let popularity: Double
    public let posterPath: String?
    public let originalLanguage: String
    public let originalTitle: String
    public let backdropPath: String?
    public let adult: Bool
    public let overview: String
    public let releaseDate: String
}
