//
//  MovieDetailViewController.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/7/19.
//  Copyright © 2019 home. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetails {
    var movie: MovieFullDescription?
    var movieService: MovieService

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var watchTrailerButton: UIButton!

    /// UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        if let info = movie {
            updateMoview(info)
        }
    }

    init(movie: MovieFullDescription, movieService: MovieService) {
        self.movie = movie
        self.movieService = movieService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        movieService = ServicesFactory.shared.movieService
        super.init(coder: aDecoder)
    }

    // MARK: - Private
    private func updateMoview(_ movie: MovieFullDescription) {
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
        overviewLabel.text = movie.overview
        genresLabel.text = movie.genres.map({ $0.name }).joined(separator: ", ")
        if let path = movie.backdropPath {
            let _ = movieService.loadImage(path: path, small: false) {[weak self] (image) in
                self?.posterImageView.image = image
            }
        }
    }

    private func showErrorBaner() {
        let alertVC = UIAlertController(title: NSLocalizedString("Error", comment: ""),
                                        message: NSLocalizedString("Something went wrong", comment: ""),
                                        preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }

    // MARK: - Actions
    @IBAction private func trailerAction(_ sender: Any) {
        guard let movie = movie else {
            return
        }
        movieService.getMovieInfoVideos(id: movie.id, success: { [weak self] (response) in
            guard let self = self, let video = response.results.first, let player = MainRouter.getYoutubePlayer(movie: video.key) as? UIViewController else {
                return
            }
            self.present(player, animated: true, completion: nil)
        }) { [weak self] in
            self?.showErrorBaner()
        }
    }

}

