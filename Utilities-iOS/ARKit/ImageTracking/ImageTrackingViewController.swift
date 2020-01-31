//  Created by SinaMN75 on 12/3/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import SceneKit
import ARKit

class ImageTrackingViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        
        guard ARReferenceImage.referenceImages(inGroupNamed: "sampleImages", bundle: nil) != nil else {
            fatalError("Images cant be load...")
        }
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

}
