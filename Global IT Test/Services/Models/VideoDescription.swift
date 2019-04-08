//
//  VideoDescription.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/8/19.
//  Copyright © 2019 home. All rights reserved.
//

/// Video description
public class VideoDescription: Decodable {
    /// Video identifier
    public let id: String
    public let key: String
    public let name: String
    public let site: String
    public let size: Int
    public let type: String
}
