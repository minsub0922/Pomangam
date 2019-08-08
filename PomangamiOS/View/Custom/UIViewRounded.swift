//
//  UITextFieldRounded.swift
//  PomangamiOS
//
//  Created by 최민섭 on 09/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class UIViewRounded: UIView {
    override func draw(_ rect: CGRect) {
        let width = CGFloat(0.8)
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = width
        layer.cornerRadius = frame.height * 0.45
        layer.masksToBounds = true
    }
}
