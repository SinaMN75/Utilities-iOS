//  Created by SinaMN75 on 9/27/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    
    @IBOutlet weak var viewVideoPlayer: UIView!
    @IBOutlet weak var viewControlls: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let url = URL(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4")
    private var player: AVPlayer!
    private var currentTime = 0
    private var duration = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayer(url: url!)
        
    }
    
    private func setupPlayer(url: URL) {
        activityIndicator.startAnimating()
        player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        viewVideoPlayer.layer.addSublayer(playerLayer)
        player.play()
        
        player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicator.isHidden = true
        }
    }
}
