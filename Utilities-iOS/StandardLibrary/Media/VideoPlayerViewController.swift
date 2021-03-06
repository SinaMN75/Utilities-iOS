//  Created by SinaMN75 on 9/27/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    
    @IBOutlet weak var viewVideoPlayer: UIView!
    @IBOutlet weak var viewControlls: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonPlayPause: UIButton!
    @IBOutlet weak var labelCurrentTime: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var labelSubtitle: UILabel!
    
    private let url = URL(string: "https://www.digikala.com/mag/wp-content/uploads/2019/09/Call-of-Duty-Modern-Warfare-Story-Trailer.mp4")
    private var player: AVPlayer!
    private var currentTimeInSecond = 0
    private var durationInSecond = 0
    private var duration: CMTime!
    private var isSeeking = false
    
    let parser = Subtitles(file: URL(fileURLWithPath: Bundle.main.path(forResource: "toyStory", ofType: "srt")!), encoding: .utf8)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayer(url: url!)
        setupGradientLayer()
    }
    
    private func setupPlayer(url: URL) {
        player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        viewVideoPlayer.layer.addSublayer(playerLayer)
        player.play()
        
        duration = player.currentItem?.asset.duration
        let seconds = CMTimeGetSeconds(duration)
        durationInSecond = Int(seconds)
        labelDuration.text = "\(durationInSecond.asMinute()):\(durationInSecond.asSecond())"
        
        player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        setupProgress()
    }
    
    private func setupProgress() {
        player.addPeriodicTimeObserver(forInterval: CMTime(value: 5, timescale: 5), queue: .main) { cmTime in
            if !self.isSeeking  {
                let seconds = CMTimeGetSeconds(cmTime)
                self.currentTimeInSecond = Int(seconds)
                self.labelCurrentTime.text = "\(Int(seconds).asMinute()):\(Int(seconds).asSecond())"
                self.slider.value = Float(seconds / CMTimeGetSeconds(self.duration))
                
                self.labelSubtitle.text = self.parser.searchSubtitles(at: seconds)
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicator.isHidden = true
            buttonPlayPause.isHidden = false
        }
    }
    
    @IBAction func buttonPlayPauseClicked(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
            sender.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player.play()
            sender.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.isSeeking = true
        player.pause()
        let seconds = CMTimeGetSeconds(duration)
        let value = Float64(slider.value) * seconds
        let seekTime = CMTime(value: Int64(value), timescale: 1)
        player.seek(to: seekTime) { b in
            self.isSeeking = false
            self.activityIndicator.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.player.play()
                self.activityIndicator.isHidden = true
            }
        }
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        viewControlls.layer.addSublayer(gradientLayer)
    }
}
