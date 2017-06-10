//
//  GSKTextFieldHeaderView.swift
//  Example
//
//  Created by Jose Alcalá-Correa on 8/1/17.
//  Copyright © 2017 Jose Alcalá Correa. All rights reserved.
//

import GSKStretchyHeaderView
import Masonry

class GSKTextFieldHeaderView: GSKStretchyHeaderView {
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.size = CGSize(width: 280, height: 32)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.maximumContentHeight = self.width
        self.minimumContentHeight = 64
        self.backgroundColor = UIColor.red
        
        self.contentView.addSubview(self.textField)
        self.textField.mas_makeConstraints { make in
            let _ = make?.size.equalTo()(CGSize(width: 280, height: 32))
            let _ = make?.center.equalTo()(self.contentView)?.centerOffset()(CGPoint(x: 8, y: 8))
        }
        
    }
    
}
