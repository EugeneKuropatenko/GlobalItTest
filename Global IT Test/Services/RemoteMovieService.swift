//
//  RemoteMovieService.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/7/19.
//  Copyright © 2019 home. All rights reserved.
//

import UIKit

private let apiKey = "640e4074503438e5fdbe9ece81bcdd4a"

class RemoteMovieService: RemoteServiceBase, MovieService {
    private var searchRequest: URLSessionDataTask?

    func getPopularMovies(page: Int, success: ((_ moviesContainer: MoviesResponseContainer) -> Void)?, failure: (() -> Void)?) {
        do {
            let remoteRequest = try prepareGetPopularRequest(page: page)
            let result = session.dataTask(with: remoteRequest) { (data, _, error) in
                if let _ = error {
                    DispatchQueue.main.async {
                        failure?()
                    }
                } else if let data = data {
                    do {
                        let response = try self.decoder.decode(MoviesResponseContainer.self, from: data)
                        DispatchQueue.main.async {
                            success?(response)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
            }
            result.resume()
        } catch {
            failure?()
        }
    }

    func loadImage(path: String, small: Bool, success: @escaping (_ image: UIImage?) -> Void) -> URLSessionDataTask? {
        do {
            let remoteRequest = try prepareLoadImageRequest(small: small, path: path)
            let result = session.dataTask(with: remoteRequest) { (data, _, _) in
                if let data = data, let image = UIImage.init(data: data) {
                    DispatchQueue.main.async {
                        success(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        success(nil)
                    }
                }
            }
            result.resume()
            return result
        } catch {
            success(nil)
            return nil
        }
    }

    func getMovieInfo(id: Int, success: ((_ moviesContainer: MovieFullDescription) -> Void)?, failure: (() -> Void)?) {
        do {
            let remoteRequest = try prepareMovieInfoRequest(id: id)
            let result = session.dataTask(with: remoteRequest) { (data, _, error) in
                if let _ = error {
                    DispatchQueue.main.async {
                        failure?()
                    }
                } else if let data = data {
                    do {
                        let response = try self.decoder.decode(MovieFullDescription.self, from: data)
                        DispatchQueue.main.async {
                            success?(response)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
            }
            result.resume()
        } catch {
            failure?()
        }
    }

    func getMovieInfoVideos(id: Int, success: ((_ moviesContainer: VideosResponseContainer) -> Void)?, failure: (() -> Void)?) {
        do {
            let remoteRequest = try prepareVideosRequest(id: id)
            let result = session.dataTask(with: remoteRequest) { (data, _, error) in
                if let _ = error {
                    DispatchQueue.main.async {
                        failure?()
                    }
                } else if let data = data {
                    do {
                        let response = try self.decoder.decode(VideosResponseContainer.self, from: data)
                        DispatchQueue.main.async {
                            success?(response)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
            }
            result.resume()
        } catch {
            failure?()
        }
    }

    func getSearchMovies(query: String, page: Int, success: ((_ moviesContainer: MoviesResponseContainer) -> Void)?, failure: (() -> Void)?) {
        searchRequest?.cancel()
        do {
            let remoteRequest = try prepareSearchRequest(query: query, page: page)
            let result = session.dataTask(with: remoteRequest) { (data, _, error) in
                if let _ = error {
                    DispatchQueue.main.async {
                        failure?()
                    }
                } else if let data = data {
                    do {
                        let response = try self.decoder.decode(MoviesResponseContainer.self, from: data)
                        DispatchQueue.main.async {
                            success?(response)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
            }
            result.resume()
        } catch {
            failure?()
        }
    }


    // MARK: - Private
    private func prepareGetPopularRequest(page: Int) throws -> URLRequest {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        return try prepareCommonRequest(method: "GET", path: "/3/movie/popular", queryItems: queryItems)
    }

    private func prepareLoadImageRequest(small: Bool, path: String) throws -> URLRequest {
        let components = NSURLComponents(string: "https://image.tmdb.org")!
        components.path = "/t/p/" + (small ? "w185" :"w500") + path
        var remoteRequest = URLRequest(url: components.url!)
        remoteRequest.httpMethod = "GET"
        remoteRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return remoteRequest
    }

    private func prepareMovieInfoRequest(id: Int) throws -> URLRequest {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        return try prepareCommonRequest(method: "GET", path: "/3/movie/\(id)", queryItems: queryItems)
    }

    private func prepareVideosRequest(id: Int) throws -> URLRequest {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "movie_id", value: String(id)),
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        return try prepareCommonRequest(method: "GET", path: "/3/movie/\(id)/videos", queryItems: queryItems)
    }

    private func prepareSearchRequest(query: String, page: Int) throws -> URLRequest {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        return try prepareCommonRequest(method: "GET", path: "/3/search/movie", queryItems: queryItems)
    }

}
