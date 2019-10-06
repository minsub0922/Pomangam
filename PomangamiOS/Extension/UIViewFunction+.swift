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
        self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: widthRatio).isActive = true
        
        if let topConstraint = topConstraint {
            self.topAnchor.constraint(equalTo: topConstraint.bottomAnchor).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        }
        
        if let bottomConstraint = bottomConstraint {
            self.bottomAnchor.constraint(equalTo: bottomConstraint.topAnchor).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        }
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
    
    //can add animation during reloadData
//    func reloadData(completion: @escaping () -> Void) {
//        UIView.animate(withDuration: 0, animations: { self.reloadData() })
//        completion()
//    }
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
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func reloadSection(section: Int) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.reloadSections(IndexSet(section...section))
            })
        }
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
    
    func loadImageAsyc(fromURL stringUrl : String, fromPomangamAPI: Bool = true) {
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
                guard let data = data, let imageToCache = UIImage(data: data) else {
                    print("Image Data Error")
                    return
                }
                
                if self.url == stringUrl {
                    DispatchQueue.main.async {
                        self.image = imageToCache
                        imageCache.setObject(imageToCache, forKey: stringUrl as AnyObject)
                    }
                }
            }
        }.resume()
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
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
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
