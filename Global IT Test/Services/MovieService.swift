//
//  MovieService.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/7/19.
//  Copyright © 2019 home. All rights reserved.
//

import UIKit

/// Movies service
public protocol MovieService {
    /// Get list of popular movies
    func getPopularMovies(page: Int, success: ((_ moviesContainer: MoviesResponseContainer) -> Void)?, failure: (() -> Void)?)

    /// Get movie's full info
    func getMovieInfo(id: Int, success: ((_ moviesContainer: MovieFullDescription) -> Void)?, failure: (() -> Void)?)

    /// Get movie's videos
    func getMovieInfoVideos(id: Int, success: ((_ moviesContainer: VideosResponseContainer) -> Void)?, failure: (() -> Void)?)

    /// Get movie's image
    func loadImage(path: String, small: Bool, success: @escaping (_ image: UIImage?) -> Void) -> URLSessionDataTask?

    /// Get list of movies contains query string
    func getSearchMovies(query: String, page: Int, success: ((_ moviesContainer: MoviesResponseContainer) -> Void)?, failure: (() -> Void)?)
}
