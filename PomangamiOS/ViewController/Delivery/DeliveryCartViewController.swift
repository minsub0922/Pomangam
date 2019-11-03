//
//  DeliveryCartViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import RealmSwift

class DeliveryCartViewController: BaseViewController {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var deliveryOrderForm: DeliveryOrderForm!
    private var orders: [SingleOrder] = []
    private var isExpanded = [Bool]()
    private var totalPrice = 0

    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "장바구니"
        setupOrderButton()
        setupCollectionView()
        readCartDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- setupView
    private func setupOrderButton() {
        deliveryOrderForm = DeliveryOrderForm(delegate: self)
        deliveryOrderForm.onlyOrderButton = true
        self.view.addSubview(deliveryOrderForm)
        deliveryOrderForm.attachOnBottom(parent: self.view, height: 60 + UIApplication.shared.safeAreaBottomInset)
    }
    
    private func setupCollectionView() {
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
            collectionView.bottomAnchor.constraint(equalTo: deliveryOrderForm.topAnchor, constant: -10)
        ])
    }
    
    //MARK:- Functions
    private func updateTotalPrice() {
        self.totalPrice = self.orders.reduce(0) {
            let productPrice = ($1.product?.price ?? 0)
            let productAmount = $1.product?.amount ?? 1
            return $0 + productPrice*productAmount
        }
          
        self.collectionView.reloadSection(section: self.orders.count+1)
    }
    
    private func readCartDatas() {
        if let res = RealmManger.getObjects(type: SingleOrder.self, byKeyPath: SingleOrder.primaryKey()) {
            self.orders = res.compactMap{ $0 }
            self.isExpanded = Array(repeating: false, count: orders.count+1)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.updateTotalPrice()
            }
        }
    }
}

//MARK:- CollectionViewDelegate
extension DeliveryCartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //CellType : 0: arrival, 1~orders.count: orders, orders.count+1: totalPrice
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2+orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10)
        case orders.count+1:
            return CGSize(width: UIScreen.main.bounds.width, height: 60)
        default:
            if isExpanded[indexPath.section] { return CGSize(width: UIScreen.main.bounds.width, height: 30) }
            else { return CGSize(width: 1, height: 1) }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch section {
        case 0, orders.count+1:
            return .zero
        default:
            if isExpanded[section] { return CGSize(width: UIScreen.main.bounds.width, height: 40) }
            else { return .zero }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0, orders.count+1:
            return .zero
        default:
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0, orders.count+1:
            return UICollectionReusableView()
        default:
            if kind.elementsEqual(UICollectionView.elementKindSectionHeader) {
                let headerView = collectionView.dequeueReusableSupplement(DeliveryCartOrderHeaderView.self, kind: kind, for: indexPath)
                guard let product = orders[indexPath.section-1].product else {return headerView}
                
                if headerView.indexPath == indexPath { return headerView }
                headerView.setupView(model: DeliveryCartOrderHeaderViewModel(imagePath: product.imagePath,
                                                                             menuName: product.name,
                                                                             menuPrice: product.price,
                                                                             amount: product.amount))
                headerView.delegate = self
                headerView.indexPath = indexPath
                return headerView
            } else {
                let footerView = collectionView.dequeueReusableSupplement(DeliveryCartOrderFooterView.self, kind: kind, for: indexPath)
                footerView.setupView(request: orders[indexPath.section-1].request)
                return footerView
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, orders.count+1:
            return 1
        default:
            return orders[section-1].options.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(DeliveryArrivalCell.self, for: indexPath)
            return cell
        case orders.count+1:
            let cell = collectionView.dequeueReusableCell(DeliveryCartPriceCell.self, for: indexPath)
            cell.setupView(totalPrice: totalPrice)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(DeliveryCartOrderCell.self, for: indexPath)
            return cell
        }
    }
}

//MARK:- DeliveryOrderForm Button Action
extension DeliveryCartViewController: DeliveryOrderFormDelegate {
    func tapDirectOrderButton() {
        print("tapDirectorderButton")
    }
}

//MARK:- DeliveryCartOrderHeader Button Actions
extension DeliveryCartViewController: DeliveryCartOrderHeaderViewProtocol {
    func expandableButtonTapAction(indexPath: IndexPath) {
        isExpanded[indexPath.section] = !isExpanded[indexPath.section]
        if orders[indexPath.section-1].options.count > 0 || orders[indexPath.section-1].request != String() {
            self.collectionView.reloadSection(section: indexPath.section, animation: true)
        }
    }
    
    func amountDecreaseButtonTapAction(indexPath: IndexPath) {
        RealmManger.updateData {
            self.orders[indexPath.section-1].product?.amount -= 1
            self.collectionView.reloadSection(section: indexPath.section, animation: false)
            self.updateTotalPrice()
        }
    }
    
    func amountIncreaseButtonTapAction(indexPath: IndexPath) {
        RealmManger.updateData {
            self.orders[indexPath.section-1].product?.amount += 1
            self.collectionView.reloadSection(section: indexPath.section, animation: false)
            self.updateTotalPrice()
        }
    }
    
    func deleteOrderButtonTapAction(indexPath: IndexPath) {
        
    }
}
