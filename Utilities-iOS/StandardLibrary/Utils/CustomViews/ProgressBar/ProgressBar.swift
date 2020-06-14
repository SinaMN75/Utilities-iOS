//  Created by SinaMN75 on 2/15/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import UIKit

class ProgressBar : UIView {
    
    var isDownloading = false
        
    @IBOutlet var viewBackground: UIView!
    @IBOutlet weak var progressView: RPCircularProgress!
    @IBOutlet weak var labelPercent: UILabel!
    @IBOutlet weak var buttonStop: UIButton!
    
    @IBAction func buttonStopAction(_ sender: Any) {
        if isDownloading { hideProgress() }
        else { showProgress() }
        downloadOrStop?()
    }
    
    var downloadOrStop: (()->Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _ = loadViewFromNib()
    }
    
    func updateProgress(progress: Float) {
        showProgress()
        progressView.enableIndeterminate(false, completion: nil)
        labelPercent.text = "\(Int(progress * 100))%"
        progressView.updateProgress(CGFloat(progress), animated: true, initialDelay: 0.1, duration: 1, completion: nil)
        buttonStop.setImage(#imageLiteral(resourceName: "stop.png"), for: .normal)
    }
    
    func loadViewFromNib() -> UIView {
        let view = UINib(nibName: "ProgressBar", bundle: Bundle.init(for: type(of: self))).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        return view
    }
    
    func hideProgress() {
        isDownloading = false
        progressView.isHidden = true
        labelPercent.isHidden = true
        buttonStop.setImage(#imageLiteral(resourceName: "download.png"), for: .normal)
        progressView.enableIndeterminate(false, completion: nil)
    }
    
    func showProgress() {
        isDownloading = true
        progressView.isHidden = false
        labelPercent.isHidden = false
        buttonStop.setImage(#imageLiteral(resourceName: "stop.png"), for: .normal)
        progressView.enableIndeterminate()
    }
}
