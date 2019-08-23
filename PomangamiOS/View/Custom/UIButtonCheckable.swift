//
//  UIButtonCheckable.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class UIButtonCheckable : UIButton {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        isSelected = !isSelected
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10 , bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        contentHorizontalAlignment = .left
    }
}
