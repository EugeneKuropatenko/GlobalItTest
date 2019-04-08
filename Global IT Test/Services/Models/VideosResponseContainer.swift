//
//  VideosResponseContainer.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/8/19.
//  Copyright © 2019 home. All rights reserved.
//

/// Videos response container.
public class VideosResponseContainer: Decodable {

    /// Video id.
    public let id: Int

    /// Videos
    public let results: [VideoDescription]

}
