//
//  ViewExtensions.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

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
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cellClass.className, for: indexPath) as! T
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
