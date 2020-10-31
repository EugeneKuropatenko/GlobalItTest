//
//  RemoteServiceError.swift
//  Global IT Test
//
//  Created by Yevgeniy Kuropatenko on 31.10.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

public struct RemoteServiceError: Error, LocalizedError, CustomNSError {

    public let errorDescription: String?
    public let errorCode: Int

    init(code: Int, errorDescription: String?) {
        self.errorCode = code
        self.errorDescription = errorDescription
    }

    public static var errorDomain: String {
        return "remote-service"
    }

    public static var supportedCodes: [Int] {
        return []
    }

}

extension RemoteServiceError {

    /// URL not supported.
    static let invalidURL = RemoteServiceError(code: -9000, errorDescription: "Invalid URL!")

}

func ~= (pattern: RemoteServiceError, value: Error) -> Bool {
    return (value as? CustomNSError)?.errorCode == pattern.errorCode
}
