//
//  ViewExtensions.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIView {
    func addRounded(radius: CGFloat = 16.0) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func changeHeight(by dHeight: Double) {
        let center = self.center
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height + CGFloat(dHeight) < 0 ? 0 : self.frame.height + CGFloat(dHeight))
        self.center = center
    }
    
    func setupShadow(shadowRadius: CGFloat = 8.0, shadowDepth: CGFloat = 4, opacity: Float = 0.3) {
        self.layer.shadowOffset = CGSize(width: 0, height: shadowDepth)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius   //퍼짐 정도
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             byRoundingCorners: .allCorners,
                                             cornerRadii: CGSize(width: 4, height: 3)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.masksToBounds = false
    }
    
    func removeShadow() {
        self.layer.shadowOpacity = 0
    }
    
//    // MARK: Set Shadow on the view without bound limited
//    private func applyShadow(radius: CGFloat = 0.0, opacity: Float = 0.3) {
//        self.layer.cornerRadius = radius
//        self.layer.shadowOffset = CGSize(width: 0, height: 2)
//        self.layer.shadowRadius = radius
//        self.layer.shadowOpacity = opacity
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 3, height: 2)).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
//        self.layer.masksToBounds = false
//    }
    
    func addAutoLayout(parent: UIView, topConstraint: UIView? = nil, bottomConstraint: UIView? = nil, heightRatio: CGFloat = 1, widthRatio: CGFloat = 1) {
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
//        self.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        
//        if let topConstraint = topConstraint {
//            self.topAnchor.constraint(equalTo: topConstraint.bottomAnchor).isActive = true
//        } else {
//            self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
//        }
        self.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: heightRatio).isActive = true
        self.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: widthRatio).isActive = true
        self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        
//        if let bottomConstraint = bottomConstraint {
//            self.bottomAnchor.constraint(equalTo: bottomConstraint.topAnchor).isActive = true
//        } else {
//            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
//        }
    }
    
    func addAutoLayout(top: NSLayoutYAxisAnchor? = nil,
                       left: NSLayoutXAxisAnchor? = nil,
                       right: NSLayoutXAxisAnchor? = nil,
                       bottom: NSLayoutYAxisAnchor? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom).isActive = true
        }
    }
    
    func attachOnBottom(parent: UIView, on: UIView? = nil, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        if let on = on {
            self.bottomAnchor.constraint(equalTo: on.topAnchor).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        }
        
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func attachOnTop(parent: UIView, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    enum DividerPosition {
        case top, bottom
    }
    
    func addDivider(on: DividerPosition, height: CGFloat = 1) {
        let divider = UIView()
        self.addSubview(divider)
        divider.backgroundColor = .dividerColor
        switch on {
        case .top:
            divider.attachOnTop(parent: self, height: height)
        case .bottom:
            divider.attachOnBottom(parent: self, height: height)
        }
    }
}

extension UILabel {
    func fontToFitHeight() {
        var minFontSize: CGFloat = font.pointSize * 0.6 // CGFloat 18
        var maxFontSize: CGFloat = font.pointSize     // CGFloat 67
        var fontSizeAverage: CGFloat = 0
        var textAndLabelHeightDiff: CGFloat = 0
        
        while (minFontSize <= maxFontSize) {
            
            fontSizeAverage = minFontSize + (maxFontSize - minFontSize) / 4
            
            guard (text?.count)! > 0 else {
                break
            }
            
            if let labelText: NSString = text as NSString? {
                let labelHeight = frame.size.height
                
                let testStringHeight = labelText.size(
                    withAttributes: [NSAttributedString.Key.font: font.withSize(fontSizeAverage)]
                    ).height
                
                textAndLabelHeightDiff = labelHeight - testStringHeight
                
                if (fontSizeAverage == minFontSize || fontSizeAverage == maxFontSize) {
                    if (textAndLabelHeightDiff < 0) {
                        self.font = font.withSize(fontSizeAverage - 1)
                        return
                    }
                    
                    self.font  = font.withSize(fontSizeAverage)
                    return
                }
                
                if (textAndLabelHeightDiff < 0) {
                    maxFontSize = fontSizeAverage - 1
                    
                } else if (textAndLabelHeightDiff > 0) {
                    minFontSize = fontSizeAverage + 1
                    
                } else {
                    self.font = font.withSize(fontSizeAverage)
                    return 
                }
            }
        }
        self.font = font.withSize(fontSizeAverage)
    }
}

extension UIButton {
    func centerImageAndButton(_ gap: CGFloat, imageOnTop: Bool) {
        
        guard let imageView = self.imageView,
            let titleLabel = self.titleLabel else { return }
        
        let sign: CGFloat = imageOnTop ? 1 : -1
        let imageSize = imageView.frame.size
        self.titleEdgeInsets = UIEdgeInsets.init(top: (imageSize.height+gap)*sign,
                                                 left: -imageSize.width,
                                                 bottom: 0,
                                                 right: 0)
        
        let titleSize = titleLabel.bounds.size
        self.imageEdgeInsets = UIEdgeInsets.init(top: -(titleSize.height+gap)*sign,
                                                 left: 0,
                                                 bottom: 0,
                                                 right: -titleSize.width)
    }
    
    func addImage(image: UIImage, on: Direction = Direction.right) {
        self.setImage(image, for: .normal)
        if on == Direction.left {
            self.semanticContentAttribute = .forceLeftToRight
            self.sizeToFit()
        } else {
            self.sizeToFit()
            self.semanticContentAttribute = .forceRightToLeft
        }
        
        
    }
}

enum Direction {
    case left
    case right
}

extension CALayer {
    // Sketch 스타일의 그림자를 생성하는 유틸리티 함수
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
        ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
    
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

extension UITabBar {
    // 기본 그림자 스타일을 초기화해야 커스텀 스타일을 적용할 수 있다.
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

extension UITableView {
    func registerNib<T: UITableViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
    func registerHeaderFooterNib<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
        let reuseIdentifier = viewClass.className
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cellClass.className, for: indexPath) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: cellClass.className) as! T
    }
    
    func registerNib<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        self.register(cellClass, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: cellClass.className) as! T
    }
    
    func reloadSection(section: Int, completion: @escaping () -> Void = {}) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.reloadSections(IndexSet(section...section), with: .automatic)
            }, completion: { _ in
                completion()
            })
        }
    }
}

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func registerSupplementaryNib<T: UICollectionReusableView>(_ viewClass: T.Type, isHeaderFooter: Int) {
        let stringName = isHeaderFooter == 0 ? UICollectionView.elementKindSectionHeader : UICollectionView.elementKindSectionFooter
        let reuseIdentifier = viewClass.className
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: stringName, withReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cellClass.className, for: indexPath) as! T
    }
    
    func dequeueReusableSupplement<T: UICollectionReusableView>(_ cellClass: T.Type, kind: String, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellClass.className, for: indexPath) as! T
    }
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func reloadSection(section: Int, animation: Bool = true) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: animation ? 0.5 : 0, animations: {
                self.reloadSections(IndexSet(section...section))
            })
        }
    }
    
    func reloadItemsWithAnimation(at: [IndexPath]) {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.reloadItems(at: at)
                          }, completion: nil)
    }
}

extension UITableViewCell {
    func setBasicHorizontalMargin(){
        let newWidth = frame.width * 0.80 // get 80% width here
        let space = (frame.width - newWidth) / 2
        frame.size.width = newWidth
        frame.origin.x += space
    }
}

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(_ viewControllerClass: T.Type) -> T {
        return self.instantiateViewController(withIdentifier: viewControllerClass.className) as! T
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    private static var _url = [String:String]()
    
    var url: String {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIImageView._url[tmpAddress] ?? ""
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIImageView._url[tmpAddress] = newValue
        }
    }
    
    func loadImageAsyc(fromURL stringUrl : String, fromPomangamAPI: Bool = true, completion: @escaping () -> Void = {}) {
        let stringUrl = API.baseURL + stringUrl
        guard let url = URL(string: stringUrl) else { return }
        
        self.url = stringUrl
        
        if let imageFromCache = imageCache.object(forKey: stringUrl as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data:Data?, res:URLResponse?, error:Error?) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            DispatchQueue.global().async {
                guard let data = data, let imageToCache = UIImage(data: data)?.compressTo(bytes: 10) else {
                    print("Image Data Error")
                    return
                }
                
                self.checkDataSize(data: data)
                
                if self.url == stringUrl {
                    DispatchQueue.main.async {
                        UIView.transition(with: self,
                                          duration:0.5,
                                          options: .transitionCrossDissolve,
                                          animations: { self.image = imageToCache }) { _ in
                                            completion()
                        }
                        imageCache.setObject(imageToCache, forKey: stringUrl as AnyObject)
                    }
                }
            }
        }.resume()
    }
    
    private func checkDataSize(data: Data) {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useKB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(data.count))
        print(Int64(data.count))
        print("formatted result: \(string)")
    }
}

extension UIImage {
    var uncompressedPNGData: NSData      { return self.pngData()! as NSData                          }
    var highestQualityJPEGNSData: NSData { return self.jpegData(compressionQuality: 1.0)! as NSData  }
    var highQualityJPEGNSData: NSData    { return self.jpegData(compressionQuality: 0.75)! as NSData }
    var mediumQualityJPEGNSData: NSData  { return self.jpegData(compressionQuality: 0.5)! as NSData  }
    var lowQualityJPEGNSData: NSData     { return self.jpegData(compressionQuality: 0.25)! as NSData }
    var lowestQualityJPEGNSData:NSData   { return self.jpegData(compressionQuality: 0.0)! as NSData  }
    
    func compressTo(bytes: Int) -> UIImage {
       var compression: CGFloat = 0.9
       let maxCompression: CGFloat = 0.1
       let maxSize: Int = bytes * 1024
       var imageData = jpegData(compressionQuality: compression)!
       while imageData.count > maxSize && compression > maxCompression {
           compression -= 0.1
           imageData = jpegData(compressionQuality: compression)!
       }
        
        

        return UIImage(data: imageData)!
   }
}

extension UIViewController {
    enum TransitionStyle {
        case rightToLeft
    }
    
    func presentDetail(target: UIViewController, style: TransitionStyle) {
        switch style {
        case .rightToLeft:
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
//            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window?.layer.add(transition, forKey: kCATransition)
        }
        self.present(target, animated: false, completion: nil)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
}

