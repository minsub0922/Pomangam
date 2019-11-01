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
    public var productsType: Int? {
        didSet {
            if let productsType = productsType {
                getMenuList(productsType: productsType)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = .white
        setupCollectionView()
    }
    
    private func getMenuList(productsType: Int) {
        guard let storeId = CurrentMarket.shared.index else {
            print("there is no currentMarket!")
            return
        }
                
        let productsType = productsType == 0 ? nil : MenuType(rawValue: productsType - 1)
        APISource.shared.getMenuList(storeIndex: storeId, type: productsType) { menuList in
            DispatchQueue.main.async {
                self.menuList = menuList
                self.isHidden = false
                self.collectionView.reloadSection(section: 0)
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let target = UIStoryboard.init(name: "Delivery", bundle: nil).instantiateViewController(DeliveryOrderViewController.self)
        target.setPacket(packet: menuList[indexPath.row])
        
        DeliveryCommon.shared
            .navigationController?
            .pushViewController(storyboard: "Delivery",
                                viewController: DeliveryOrderViewController.self,
                                packet: menuList[indexPath.row])
//            .presentDetail(target: target, style: .rightToLeft)
    }
    
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
