//
//  MovieCatalogViewController.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/7/19.
//  Copyright © 2019 home. All rights reserved.
//

import UIKit

class MovieCatalogViewController: UIViewController, MovieCatalog {

    var movieService: MovieService!

    @IBOutlet private weak var mainTable: UITableView!
    private lazy var paginator: PageDescribe = PageDescribe<MovieDescription>()
    private var imageRequests: [AnyHashable: URLSessionDataTask] = [:]
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refetchList), for: .valueChanged)
        return control
    }()

    /// UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.tableFooterView = UIView()
        mainTable.refreshControl = refreshControl
        fetch(reset: true)
    }

    init(movieService: MovieService) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selected = mainTable.indexPathForSelectedRow {
            mainTable.deselectRow(at: selected, animated: animated)
        }
    }

    // MARK: - Private
    private func fetch(reset: Bool = false) {
        guard reset || !paginator.isLoading else {
            return
        }
        paginator.isLoading = true
        if reset {
            paginator.lastPage = 0
            paginator.results = []
        }
        movieService.getPopularMovies(page: paginator.lastPage + 1, success: {[weak self] (container) in
            guard let self = self else {
                return
            }
            self.paginator.lastPage = container.page
            self.paginator.totalPages = container.totalPages
            self.paginator.totalResults = container.totalResults
            self.paginator.isLoading = false

            if container.page == 1 {
                self.paginator.results = container.results
                self.mainTable.reloadData()
            } else {
                self.mainTable.beginUpdates()
                self.mainTable.insertRows(at: container.results.enumerated().map({ IndexPath(row: $0.offset + self.paginator.results.count, section: 0) }), with: .automatic)
                self.paginator.results += container.results
                self.mainTable.endUpdates()
            }
            self.refreshControl.endRefreshing()
        }) { [weak self] in
            self?.showErrorBaner()
            self?.paginator.isLoading = false
            self?.refreshControl.endRefreshing()
        }
    }

    private func configure(cell: MovieTableViewCell, data: MovieDescription) {
        cell.movieTitle = data.title
        cell.posterImage = nil
        if let path = data.backdropPath {
            imageRequests[cell]?.cancel()
            let request = movieService.loadImage(path: path, small: true) {[weak cell] (image) in
                cell?.posterImage = image
            }
            imageRequests[cell] = request
        }
    }

    fileprivate func showErrorBaner() {
        let alertVC = UIAlertController(title: NSLocalizedString("Error", comment: ""),
                                        message: NSLocalizedString("Something went wrong", comment: ""),
                                        preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @objc
    func refetchList() {
        fetch(reset: true)
    }

}

extension MovieCatalogViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginator.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        configure(cell: cell, data: paginator.results[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= tableView.numberOfRows(inSection: indexPath.section) - 4 {
            fetch()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moview = paginator.results[indexPath.row]
        movieService.getMovieInfo(id: moview.id, success: { [weak self] (fullInfo) in
            guard let self = self else {
                return
            }
            let detailsVC = MainRouter.getMovieDetails(movie: fullInfo, self.movieService) as! UIViewController
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }) { [weak self] in
            self?.showErrorBaner()
        }
    }
}
