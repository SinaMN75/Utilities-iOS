//  Created by SinaMN75 on 8/10/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    var blueColor: UIColor = UIColor( red: 73/255, green: 104/255, blue: 177/255, alpha: 1.0)
    
    var decodedDataStackView: UIStackView!
    
    var decodedData = ["Series and number :":"A1234 issued in 2006 (06)",
                       "Nature of the NOTAM :":"Replacing (R) NOTAM 1212 issued in 2006 (06)",
                       "FIR :":"London FIR (EGTT)",
                       "Subject :":"Taxiway (MX)",
                       "Condition :":"Closed (LC)",
                       "Traffic :":"NOTAM issued for IFR (I) flights and VFR flights (V)",
                       "Purpose :":"NOTAM selected for immediate attention of flight crew members ",
                       "Scope :":"(N), for PIB entry (B), concerning flight operations",
                       "Limits :":"Aerodrome (A)",
                       "Geographical location :":"FL 000 to FL 999 (000/999)",
                       "Operation radius :":"51°29' N 000° 28' W (5129N00028W)",
                       "Aerodrome :":"5 NM (005)",
                       "From :":"London Heathrow (EGLL)",
                       "Until :":"05:00 UTC 5 September 2006 (060905 0500)",
                       "Category : :":"Aerodromes, air routes, and ground aids",
                       "Description :":"Description: Due to work in progress (DUE WIP)"]
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.decodedDataStackView = UIStackView()
        self.decodedDataStackView.backgroundColor = .blue
        self.decodedDataStackView.axis = .vertical
        self.decodedDataStackView.alignment = .fill
        self.decodedDataStackView.distribution = .fillProportionally
        self.decodedDataStackView.spacing = 0
        viewContainer.addSubview(self.decodedDataStackView)
        
        self.decodedDataStackView.translatesAutoresizingMaskIntoConstraints = false
        self.decodedDataStackView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        self.decodedDataStackView.topAnchor.constraint(equalTo: viewTop.bottomAnchor, constant: 10).isActive = true
        self.decodedDataStackView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 40).isActive = true
        self.decodedDataStackView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -40).isActive = true
        
        for (title, Value) in decodedData {
            self.decodedDataStackView.addArrangedSubview(TitleAndValueView(title: title, value: Value, valuePosition: .right, distance: 20))
        }
    }
}
