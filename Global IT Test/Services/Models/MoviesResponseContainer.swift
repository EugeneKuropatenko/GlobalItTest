//
//  MoviesResponseContainer.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/7/19.
//  Copyright © 2019 home. All rights reserved.
//

/// Movies response container.
public class MoviesResponseContainer: Decodable {

    /// Total movies.
    public let totalResults: Int

    /// Total pages.
    public let totalPages: Int

    /// Response page.
    public let page: Int

    /// Movies
    public let results: [MovieDescription]

}
