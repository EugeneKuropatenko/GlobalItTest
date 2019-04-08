//
//  MovieTableViewCell.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/7/19.
//  Copyright © 2019 home. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    var posterImage: UIImage? {
        get { return posterImageView?.image }
        set { posterImageView?.image = newValue}
    }

    var movieTitle: String? {
        get { return titleLabel?.text }
        set { titleLabel?.text = newValue }
    }

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

}
