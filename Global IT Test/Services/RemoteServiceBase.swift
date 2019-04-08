//
//  RemoteServiceBase.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/7/19.
//  Copyright © 2019 home. All rights reserved.
//

import Foundation

/// This class should not be used directly.
class RemoteServiceBase {

    let session: URLSession
    let baseURL: String
    let decoder: JSONDecoder

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = dateDecodingStrategy
    }

    // MARK: -
    func prepareCommonRequest(method: String, path: String, contentType: String = "application/json", queryItems: [URLQueryItem] = []) throws -> URLRequest {
        let components = NSURLComponents(string: baseURL)!
        components.path = path
        components.queryItems = queryItems
        var remoteRequest = URLRequest(url: components.url!)
        remoteRequest.httpMethod = method
        remoteRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
        return remoteRequest
    }

    // MARK: - Private

    private var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        let formats = ["yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ", "MM/dd/yyyy"]
        return JSONDecoder.DateDecodingStrategy.custom { decoder -> Date in
            let dateContainer = try decoder.singleValueContainer()
            let dateString = try dateContainer.decode(String.self)
            for format in formats {
                let formatter = DateFormatter()
                formatter.dateFormat = format
                if let date = formatter.date(from: dateString) {
                    return date
                }
            }
            let errorDescription = "Can't decode date string \(dateString)"
            throw DecodingError.dataCorruptedError(in: dateContainer, debugDescription: errorDescription)
        }
    }

}
