//
//  MainRouter.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/7/19.
//  Copyright © 2019 home. All rights reserved.
//

import UIKit

class MainRouter {

    /// Get View Controller with list of movies
    static func getMovieCatalog(_ movieServise: MovieService) -> MovieCatalog {
        guard let catalogVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieCatalogViewController") as? MovieCatalog else {
            fatalError("Unexpected settings module type!")
        }
        catalogVC.movieService = movieServise
        return catalogVC
    }

    /// Get View controller with movie's details
    static func getMovieDetails(movie: MovieFullDescription, _ movieServise: MovieService) -> MovieDetails {
        guard let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetails else {
            fatalError("Unexpected settings module type!")
        }
        detailsVC.movie = movie
        detailsVC.movieService = movieServise
        return detailsVC
    }

    /// Get youtube video controller
    static func getYoutubePlayer(movie: String) -> Player {
        guard let player = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YoutubePlayerViewController") as? Player else {
            fatalError("Unexpected settings module type!")
        }
        player.playVideo(path: movie)
        return player
    }

}
