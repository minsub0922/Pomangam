//
//  PageCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var preY: CGFloat = 0
    private var menuList: [MenuResponse] = []
    private let collectionViewMargin = UIScreen.main.bounds.width * 0.06
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .white
        setupCollectionView()
        
        guard let storeId = CurrentMarket.shared.index else {
            print("there is no currentMarket!")
            return
        }
        
        APISource.shared.getMenuList(storeIndex: storeId) { menuList in
            self.menuList = menuList
            self.collectionView.reloadSection(section: 0)
        
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(PageChildCell.self)
        self.addSubview(collectionView)
        
        collectionView.addAutoLayout(parent: self)
        collectionView.contentInset = UIEdgeInsets(top: 5,
                                                   left: collectionViewMargin,
                                                   bottom: UIScreen.main.bounds.height/3,
                                                   right: collectionViewMargin)
    }
}

extension PageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width-2*collectionViewMargin)/2-5
        return CGSize(width: width, height: width + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PageChildCell.self, for: indexPath)
        cell.setupView(model: menuList[indexPath.row].asDeliveryMenuCellViewModel)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        NotificationCenter.default.post(notificationName: .deliveryMenuListScrolled, object: ScrollDetails(y: preY - y))
        preY = y
    }
}
