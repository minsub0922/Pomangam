//
//  DeliveryCartViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryCartViewController: BaseViewController {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var deliveryOrderForm: DeliveryOrderForm!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "장바구니"
        setupOrderButton()
        setupTableView()
        
        guard let res = RealmManger.getObjects(type: SingleOrder.self, byKeyPath: SingleOrder.primaryKey()) else {return}
        for r in res {
            print(r)
            print(r.product?.name)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupOrderButton() {
        deliveryOrderForm = DeliveryOrderForm(delegate: self)
        deliveryOrderForm.onlyOrderButton = true
        self.view.addSubview(deliveryOrderForm)
        deliveryOrderForm.attachOnBottom(parent: self.view, height: 60 + UIApplication.shared.safeAreaBottomInset)
    }
    
    private func setupTableView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white 
        collectionView.registerNib(DeliveryArrivalCell.self)
        collectionView.registerNib(DeliveryCartOrderCell.self)
        collectionView.registerNib(DeliveryCartPriceCell.self)
        collectionView.registerSupplementaryNib(DeliveryCartOrderHeaderView.self, isHeaderFooter: 0)
        collectionView.registerSupplementaryNib(DeliveryCartOrderFooterView.self, isHeaderFooter: 1)
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: deliveryOrderForm.topAnchor, constant: 10)
        ])
    }
}

extension DeliveryCartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    enum CellType: Int {
        case arrival = 0, orders, price
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cellType = CellType(rawValue: indexPath.section) else { return .zero }
        
        switch cellType {
        case .arrival:
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6)
        case .price:
            return CGSize(width: UIScreen.main.bounds.width, height: 60)
        case .orders:
            return CGSize(width: UIScreen.main.bounds.width, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let cellType = CellType(rawValue: section) else { return .zero }
        
        switch cellType {
        case .arrival, .price:
            return .zero
        case .orders:
            return CGSize(width: UIScreen.main.bounds.width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let cellType = CellType(rawValue: section) else { return .zero }
        
        switch cellType {
        case .arrival, .price:
            return .zero
        case .orders:
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cellType = CellType(rawValue: indexPath.section) else { return UICollectionReusableView() }
        
        switch cellType {
        case .arrival, .price:
            return UICollectionReusableView()
        case .orders:
            if kind.elementsEqual(UICollectionView.elementKindSectionHeader) {
                let headerView = collectionView.dequeueReusableSupplement(DeliveryCartOrderHeaderView.self, kind: kind, for: indexPath)
                //headerView.setupView(model: DeliveryCartOrderHeaderViewModel(imagePath: <#String#>))
                return headerView
            } else {
                let footerView = collectionView.dequeueReusableSupplement(DeliveryCartOrderFooterView.self, kind: kind, for: indexPath)
                return footerView
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellType = CellType(rawValue: section) else { return 0 }
        
        switch cellType {
        case .arrival, .price:
            return 1
        case .orders:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = CellType(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch cellType {
        case .arrival:
            let cell = collectionView.dequeueReusableCell(DeliveryArrivalCell.self, for: indexPath)
            return cell
        case .price:
            let cell = collectionView.dequeueReusableCell(DeliveryCartPriceCell.self, for: indexPath)
            return cell
        case .orders:
            let cell = collectionView.dequeueReusableCell(DeliveryCartOrderCell.self, for: indexPath)
            return cell
        }
    }
}

extension DeliveryCartViewController: DeliveryOrderFormDelegate {
    func tapDirectOrderButton() {
        print("tapDirectorderButton")
    }
}
