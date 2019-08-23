//
//  UITextFieldUnderlined.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class UITextFieldUnderlined: UITextField, UITextFieldDelegate {
    let normalLineColor = UIColor.lightText
    let selectedLineColor = UIColor.dustyOrange
    let border = CALayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate=self
        setCursorColor()
        border.borderColor = normalLineColor.cgColor
        borderStyle = .none
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        border.borderColor = selectedLineColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        border.borderColor = normalLineColor.cgColor
    }
    
    private func setCursorColor(){
        tintColor = UIColor.dustyOrange
    }
    
    //draw rec -> underline
    override func draw(_ rect: CGRect) {
        let width = CGFloat(0.5)
        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: width)
        border.borderWidth = width
        layer.addSublayer(border)
    }
    
    // set padding
    struct Constants {
        static let sidePadding: CGFloat = 0
        static let topPadding: CGFloat = 15
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x + Constants.sidePadding,
            y: bounds.origin.y + Constants.topPadding,
            width: bounds.size.width - Constants.sidePadding * 2,
            height: bounds.size.height - Constants.topPadding * 1.5
        )
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
}


//@IBInspectable open var phoneNumberType: Bool = false
//@IBInspectable open var cardNumberType: Bool = false
//@IBInspectable open var maxWords: Int = Int.max
//
//func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//    let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//    let components = (newString as NSString).components(separatedBy: NSCharacterSet.decimalDigits.inverted)
//
//    let decimalString = components.joined(separator: "") as NSString
//
//    let length = decimalString.length
//
//    if length > maxWords {return false}
//
//    var index = 0 as Int
//    let formattedString = NSMutableString()
//
//    if phoneNumberType {
//
//        if (length - index) > 4 {
//            let areaCode = decimalString.substring(with: NSMakeRange(index, 4))
//            formattedString.appendFormat("%@.", areaCode)
//            index += 4
//        }
//        if length > 5, length - index > 2 {
//            let prefix = decimalString.substring(with: NSMakeRange(index, 2))
//            formattedString.appendFormat("%@.", prefix)
//            index += 2
//        }
//
//    } else if cardNumberType {
//
//        for i in 1...4 {
//            if (length - index) > 4 {
//                let areaCode = decimalString.substring(with: NSMakeRange(index, 4))
//                formattedString.appendFormat("%@-", areaCode)
//                index += 4
//            }
//        }
//    }
//
//    else {
//        return true
//    }
//
//    let remainder = decimalString.substring(from: index)
//    formattedString.append(remainder)
//    textField.text = formattedString as String
//    return false
//
//}
