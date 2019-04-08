//
//  ServicesFactory.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/7/19.
//  Copyright © 2019 home. All rights reserved.
//

class ServicesFactory {

    static var shared: ServicesFactory = {
        let endpoint = "https://api.themoviedb.org"
        let movieService = RemoteMovieService(session: .shared, baseURL: endpoint)
        return ServicesFactory(movieService)
    }()

    // MARK: -

    /// Movie service.
    let movieService: MovieService

    init(_ movieService: MovieService) {
        self.movieService = movieService
    }

}
