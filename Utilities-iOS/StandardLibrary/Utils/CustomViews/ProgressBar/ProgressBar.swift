//  Created by SinaMN75 on 2/15/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import UIKit
import RxRelay

class ProgressBar : UIView {
    
    var isDownloading = false
        
    @IBOutlet var viewBackground: UIView!
    @IBOutlet weak var progressView: RPCircularProgress!
    @IBOutlet weak var labelPercent: UILabel!
    @IBOutlet weak var buttonStop: UIButton!
    
    @IBAction func buttonStopAction(_ sender: Any) {
        if isDownloading {
            buttonStop.setImage(#imageLiteral(resourceName: "download.png"), for: .normal)
            stopAnimating()
        } else {
            buttonStop.setImage(#imageLiteral(resourceName: "stop.png"), for: .normal)
            progressView.enableIndeterminate(false, completion: nil)
            startAnimating()
        }
        
        downloadOrStop?()
    }
    
    var downloadOrStop: (()->Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _ = loadViewFromNib()
    }
    
    func startAnimating() {
        hideProgress()
        isDownloading = true
        progressView.enableIndeterminate()
        buttonStop.setImage(#imageLiteral(resourceName: "stop.png"), for: .normal)
    }
    
    func stopAnimating() {
        isDownloading = false
        progressView.enableIndeterminate(false, completion: nil)
        showProgress()
        buttonStop.setImage(#imageLiteral(resourceName: "download.png"), for: .normal)
    }
    
    func updateProgress(progress: Float) {
        hideProgress()
        isDownloading = true
        progressView.enableIndeterminate(false, completion: nil)
        labelPercent.text = "\(Int(progress * 100))%"
        progressView.updateProgress(CGFloat(progress), animated: true, initialDelay: 0.1, duration: 1, completion: nil)
        buttonStop.setImage(#imageLiteral(resourceName: "stop.png"), for: .normal)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "ProgressBar", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        return view
    }
    
    private func hideProgress() {
        progressView.isHidden = false
        labelPercent.isHidden = false
    }
    
    private func showProgress() {
        progressView.isHidden = true
        labelPercent.isHidden = true
    }
}
