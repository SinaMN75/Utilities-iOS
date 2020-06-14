//  Created by SinaMN75 on 2/22/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import UIKit

class TitleAndValueView: UIView {
    
    var titleLabel: UILabel!
    var valueLabel: UILabel!
    
    var strTitle: String = ""
    var strValue: String = ""
    
    private var valuePosition: ValuePosition = .right
    private var distance: CGFloat = 20
    
    public var titleColor: UIColor = UIColor.white { didSet{ self.titleLabel.textColor = titleColor } }
    public var valueColor: UIColor = .white { didSet { self.valueLabel.textColor = valueColor } }
    public var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 13) { didSet{ self.titleLabel.font = titleFont } }
    public var valueFont: UIFont = UIFont.systemFont(ofSize: 13) { didSet{ self.valueLabel.font = valueFont } }
    
    init(title: String, value: String, valuePosition: ValuePosition = .right, distance: CGFloat = 20){
        super.init(frame: .zero)
        self.strTitle = title
        self.strValue = value
        self.valuePosition = valuePosition
        self.distance = distance
        self._Initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._Initialize()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension TitleAndValueView{
    private func _Initialize(){
        
        self.titleLabel = UILabel()
        self.titleLabel.textColor = titleColor
        self.titleLabel.font = titleFont
        self.titleLabel.text = self.strTitle
        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        valueLabel = UILabel()
        valueLabel.textColor = valueColor
        valueLabel.font = valueFont
        valueLabel.text = self.strValue
        valueLabel.numberOfLines = 0
        self.addSubview(valueLabel)
        
        self.valueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.valueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10).isActive = true
        self.valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    public func setValue(_ value: String){
        self.strValue = value
        self.valueLabel.text = value
    }
}

public enum ValuePosition{
    case right
    case sticky
}
