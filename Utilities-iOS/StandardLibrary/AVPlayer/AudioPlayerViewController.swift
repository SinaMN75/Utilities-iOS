//  Created by SinaMN75 on 9/26/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import AVFoundation

class AudioPlayerViewController: UIViewController {
        
    private let url = "https://dl.freemp3downloads.online/file/youtubewHupN5QiGAU320.mp3?fn=%5B1%20Hour%5D%20DJ%20Regard%20-%20Ride%20It%20(Official%20Audio).mp3"

    @IBOutlet weak var imageViewBanner: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var labelCurrentPosition: UILabel!
    @IBOutlet weak var labelTotalDuration: UILabel!
    @IBOutlet weak var buttonForward: UIButton!
    @IBOutlet weak var buttonPlayPause: UIButton!
    @IBOutlet weak var buttonBackward: UIButton!
    


    var player: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let item  = AVPlayerItem.init(url: URL(string: url)!)
        player = AVPlayer(playerItem: item)

        player.play()
        
    }
    
    @IBAction func sliderValueChaned(_ sender: UISlider) {
        
    }
    
    @IBAction func buttonPlayPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func buttonForwardPressed(_ sender: Any) {
        
    }
    
    @IBAction func buttonBackwardPressed(_ sender: Any) {
        
    }
}
