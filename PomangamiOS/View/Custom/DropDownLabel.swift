//
//  DropDownLabel.swift
//  PomangamiOS
//
//  Created by 최민섭 on 15/09/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DropDownLabel: UIView {
    var text: String = ""
   
    override init(frame: CGRect) {
        super.init(frame: frame)
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        let label = UILabel(frame: frame)
        label.text = text
        label.sizeToFit()
        label.center = self.center
        self.addSubview(label)
    }
}
