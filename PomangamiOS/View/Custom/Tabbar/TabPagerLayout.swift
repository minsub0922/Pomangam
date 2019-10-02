//
//  TabPagerLayout.swift
//  PomangamiOS
//
//  Created by 최민섭 on 02/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class TabPagerLayout: UIView, CustomMenuBarDelegate{
    
    //MARK: Outltes
    var pageCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var customMenuBar = TabbarLayout()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .white
        setupHeaderView()
        
        ////
        setupCustomTabBar()
        setupPageCollectionView()
    }
    
    func setupHeaderView() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.addSubview(button)
        button.setTitle("asd", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        if #available(iOS 11.0, *) {
            button.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.backgroundColor = .orange
    }
    
    //MARK: Setup view
    func setupCustomTabBar(){
        self.addSubview(customMenuBar)
        customMenuBar.delegate = self
        customMenuBar.translatesAutoresizingMaskIntoConstraints = false
        customMenuBar.indicatorViewWidthConstraint.constant = self.frame.width / 4
        customMenuBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        customMenuBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        customMenuBar.topAnchor.constraint(equalTo: self.subviews[0].bottomAnchor).isActive = true
        customMenuBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func customMenuBar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func setupPageCollectionView(){
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.backgroundColor = .gray
        pageCollectionView.showsHorizontalScrollIndicator = false
        pageCollectionView.isPagingEnabled = true
        pageCollectionView.register(UINib(nibName: PageCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: PageCell.reusableIdentifier)
        self.addSubview(pageCollectionView)
        pageCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pageCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pageCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pageCollectionView.topAnchor.constraint(equalTo: self.customMenuBar.bottomAnchor).isActive = true
    }
}
//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension TabPagerLayout: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.reusableIdentifier, for: indexPath) as! PageCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customMenuBar.indicatorViewLeadingConstraint.constant = scrollView.contentOffset.x / 4
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        customMenuBar.customTabBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension TabPagerLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

