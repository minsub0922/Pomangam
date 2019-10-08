//
//  OrderViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 04/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol DeliveryOrderViewControllerDelegate: class {
    func navigateToDelivery<T>(packet: T)
    func navigateToDeliveryMenuList<T>(packet: T)
    //func navigateToDeliveryMenuList<T>(packet: T)
}

class DeliveryOrderViewController: BaseViewController {
    public weak var delegate: DeliveryOrderViewControllerDelegate?
    private var menudetail: MenuDetailResponse?
    private var orderSelectorView: OptionSelectorView!
    private var deliveryOrderForm: DeliveryOrderForm!
    
    var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero,
                                collectionViewLayout: UICollectionViewFlowLayout())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let menuInfo = packet as? MenuResponse else {return}
        
        APISource.shared.getMenuDetail(productIndex: menuInfo.index) { res in
            self.menudetail = res
            self.collectionView.reloadSection(section: 0)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        setupFormView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.registerNib(DeliveryOrderMenuCell.self)
        collectionView.registerNib(DeliveryOrderOptionCell.self)
        collectionView.registerNib(DeliveryOrderRequestCell.self)
        collectionView.registerSupplementaryNib(DeliveryOrderFooter.self, isHeaderFooter: 1)
        self.view.addSubview(collectionView)
        collectionView.addAutoLayout(parent: self.view)
    }
    
    private func setupFormView() {
        deliveryOrderForm = DeliveryOrderForm()
        orderSelectorView = OptionSelectorView()
        self.view.addSubview(deliveryOrderForm)
        self.view.addSubview(orderSelectorView)

        deliveryOrderForm.attachOnBottom(parent: self.view,
                                         height: 60 + UIApplication.shared.safeAreaBottomInset)
        orderSelectorView.attachOnBottom(parent: self.view,
                                         on: deliveryOrderForm,
                                         height: 60)
        
        
    }
}

//MARK:- UICollectionViewDelegate
extension DeliveryOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum CellType: Int {
        case menu = 0, options, request, amount
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellType = CellType(rawValue: section) else {
            return 0
        }
        switch cellType {
        case .menu, .request, .amount:
            return 1
        case .options:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fullSize = collectionView.bounds
        guard let cellType = CellType(rawValue: indexPath.section) else {
            return .zero
        }
        switch cellType {
        case .menu:
            return CGSize(width: fullSize.width, height: fullSize.height*0.35)
        case .options:
            return CGSize(width: fullSize.width, height: 35)
        case .request:
            return CGSize(width: fullSize.width, height: fullSize.height*0.2)
        case .amount:
            return CGSize(width: fullSize.width, height: fullSize.height*0.08)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section < numberOfSections(in: collectionView) - 1 {
            return .zero
        }
            
        let fullSize = collectionView.bounds
        return CGSize(width: fullSize.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DeliveryOrderFooter", for: indexPath) as? DeliveryOrderFooter, kind == UICollectionView.elementKindSectionFooter else {
            return UICollectionReusableView()
        }

        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = CellType(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        switch cellType {
        case .menu:
            let cell = collectionView.dequeueReusableCell(DeliveryOrderMenuCell.self, for: indexPath)
            if let menudetail = menudetail {
                cell.setupView(model: menudetail.menuInfo.asDeliveryOrderMenuViewModel)
            }
            return cell
        case .options:
            let cell = collectionView.dequeueReusableCell(DeliveryOrderOptionCell.self, for: indexPath)
            return cell
        case .request:
            let cell = collectionView.dequeueReusableCell(DeliveryOrderRequestCell.self, for: indexPath)
            return cell
        case .amount:
            let cell = collectionView.dequeueReusableCell(DeliveryOrderOptionCell.self, for: indexPath)
            cell.isOptions = false
            return cell
        }
    }
}
