//
//  PageDescribe.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/7/19.
//  Copyright © 2019 home. All rights reserved.
//

/// Describe page info for pagination
class PageDescribe<T> {
    var totalResults: Int = 0
    var totalPages: Int = 0
    var lastPage: Int = 0
    var results: [T] = []

    var isLoading = false
}
