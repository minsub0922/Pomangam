//
//  TabbarLayout.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/09/30.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol TabbarLayoutDelegate: class {
    func customMenuBar(scrollTo index: Int)
}

class TabbarLayout: UIView {
    
    //MARK: Properties
    weak var delegate: TabbarLayoutDelegate?
    var indicatorViewLeadingConstraint:NSLayoutConstraint!
    var indicatorViewWidthConstraint: NSLayoutConstraint!
    private var tabTitles: [String] = ["전체", "메인", "서브", "토핑", "음료"]
    fileprivate let indicatorRatio: CGFloat = 0.12
    fileprivate var indicatorInsetRatio: CGFloat {
        return indicatorRatio / 2
    }
    
    var customTabBarCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()

    var indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let subView = UIView()
        view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        subView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        subView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subView.backgroundColor = .dustyOrange
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCustomTabBar()
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Setup Views
    private func setupCustomTabBar(){
           setupCollectioView()
           setupIndicatorView()
       }
    
    private func setupCollectioView(){
        customTabBarCollectionView.delegate = self
        customTabBarCollectionView.dataSource = self
        customTabBarCollectionView.showsHorizontalScrollIndicator = false
        customTabBarCollectionView.registerNib(TabbarCell.self)
        customTabBarCollectionView.isScrollEnabled = false
        
        let indexPath = IndexPath(item: 0, section: 0)
        customTabBarCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        self.addSubview(customTabBarCollectionView)
        customTabBarCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        customTabBarCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        customTabBarCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        customTabBarCollectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupIndicatorView() {
        self.addSubview(indicatorView)
        indicatorViewWidthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: self.frame.width / 5)
        indicatorViewWidthConstraint.isActive = true
        indicatorView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        indicatorViewLeadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        indicatorViewLeadingConstraint.isActive = true
        indicatorView.topAnchor.constraint(equalTo: customTabBarCollectionView.bottomAnchor, constant: 0).isActive = true
    }
}

//MARK:- UICollectionViewDelegate, DataSource
extension TabbarLayout: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(TabbarCell.self, for: indexPath)
        cell.label.text = tabTitles[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 5 , height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.customMenuBar(scrollTo: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TabbarCell else {return}
        cell.label.textColor = .lightGray
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension TabbarLayout: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
