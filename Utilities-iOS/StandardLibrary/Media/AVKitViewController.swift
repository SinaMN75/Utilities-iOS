//  Created by SinaMN75 on 9/27/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import AVKit

class AVKitViewController: AVPlayerViewController {

    private let url = URL(string: "https://www.digikala.com/mag/wp-content/uploads/2019/09/Call-of-Duty-Modern-Warfare-Story-Trailer.mp4")

    override func viewDidLoad() {
        super.viewDidLoad()

        let video = AVPlayer(url: url!)
        player = video
        
        player?.play()
        
        let videoSlider: UISlider = {
            let slider = UISlider()
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumTrackTintColor = .red
            slider.maximumTrackTintColor = .white
            
            
            return slider
        }()
        
        view.addSubview(videoSlider)
    }
}
