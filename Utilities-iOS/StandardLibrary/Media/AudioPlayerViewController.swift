//  Created by SinaMN75 on 9/26/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import AVFoundation

class AudioPlayerViewController: UIViewController {

    @IBOutlet weak var imageViewBanner: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var labelCurrentPosition: UILabel!
    @IBOutlet weak var labelTotalDuration: UILabel!
    @IBOutlet weak var buttonForward: UIButton!
    @IBOutlet weak var buttonPlayPause: UIButton!
    @IBOutlet weak var buttonBackward: UIButton!
    
    private let url = URL(string: "https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_5MG.mp3")
    private var player: AVPlayer!
    private var currentTimeInSecond = 0
    private var durationInSecond = 0
    private var duration: CMTime!
    private var isSeeking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayer(url: url!)
    }
    
    private func setupPlayer(url: URL) {
        player = AVPlayer(url: url)
        player.play()
        
        duration = player.currentItem?.asset.duration
        let seconds = CMTimeGetSeconds(duration)
        durationInSecond = Int(seconds)
        labelTotalDuration.text = "\(durationInSecond.asMinute()):\(durationInSecond.asSecond())"
        
        player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        setupProgress()
    }
    
    private func setupProgress() {
        player.addPeriodicTimeObserver(forInterval: CMTime(value: 5, timescale: 5), queue: .main) { cmTime in
            if !self.isSeeking  {
                let seconds = CMTimeGetSeconds(cmTime)
                self.currentTimeInSecond = Int(seconds)
                self.labelCurrentPosition.text = "\(Int(seconds).asMinute()):\(Int(seconds).asSecond())"
                self.slider.value = Float(seconds / CMTimeGetSeconds(self.duration))
                
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            buttonPlayPause.isHidden = false
        }
    }
    
    @IBAction func sliderValueChaned(_ sender: UISlider) {
        self.isSeeking = true
        player.pause()
        let seconds = CMTimeGetSeconds(duration)
        let value = Float64(slider.value) * seconds
        let seekTime = CMTime(value: Int64(value), timescale: 1)
        player.seek(to: seekTime) { b in
            self.isSeeking = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.player.play()
            }
        }
    }
    
    @IBAction func buttonPlayPressed(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
            sender.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player.play()
            sender.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func buttonForwardPressed(_ sender: Any) {
        player.seek(to: CMTime(value: CMTimeValue(currentTimeInSecond + 10), timescale: 1))
    }
    
    @IBAction func buttonBackwardPressed(_ sender: Any) {
        player.seek(to: CMTime(value: CMTimeValue(currentTimeInSecond - 10), timescale: 1))
    }
}
