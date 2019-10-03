///
//  DeliveryViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 17/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryMenuListViewController: UIViewController {
    private var navigationButtonView: NavigationTitleDropDownButton = NavigationTitleDropDownButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        navigationButtonView.addTarget(self, action: #selector(navigationTitleTapAction(_:)), for: .touchUpInside)
        navigationButtonView.configure("학생회관 뒤")
        navigationItem.titleView = navigationButtonView
        
        let rightButton = UIBarButtonItem(image: UIImage(named: "btnDeliveryFilter"), style: .plain, target: self, action: #selector(navigationRightButtonTapAction(_:)))
        navigationItem.rightBarButtonItem  = rightButton
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(DeliveryMenuListHeaderCell.self)
        collectionView.registerNib(DeliveryTabpagerCell.self)
        self.view.addSubview(collectionView)
        collectionView.addAutoLayout(parent: self.view)
    }
    
   

    @objc private func navigationRightButtonTapAction(_ sender: Any) {
        print("tapped Right Button")
    }
    
    @objc private func navigationTitleTapAction(_ sender: Any) {
        print("touched??")
    }
}

extension DeliveryMenuListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 50)
        case 1:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(DeliveryMenuListHeaderCell.self, for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(DeliveryTabpagerCell.self, for: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
