//
//  YoutubePlayerViewController.swift
//  Global IT Test
//
//  Created by Eugene Kuropatenko on 4/8/19.
//  Copyright © 2019 home. All rights reserved.
//

import UIKit

class YoutubePlayerViewController: UIViewController, YTPlayerViewDelegate {
    @IBOutlet fileprivate weak var playerView: YTPlayerView!
    @IBOutlet private weak var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
    }

    // MARK: - Actions
    @IBAction func doneAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - YTPlayerViewDelegate
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        if state == .ended || state == .unknown {
            dismiss(animated: true, completion: nil)
        } else if state == .playing {
            doneButton.isHidden = true
        } else if state == .paused {
            doneButton.isHidden = false
        }
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}

extension YoutubePlayerViewController: Player {
    func playVideo(path: String) {
        loadViewIfNeeded()
        if !playerView.load(videoId: path) {
            dismiss(animated: false, completion: nil)
        }
    }
}
