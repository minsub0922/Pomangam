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
    private var orderSelectorView: OptionSelectorView!
    private var deliveryOrderForm: DeliveryOrderForm!
    private var options: [MenuResponse] = []
    private var menudetail: MenuDetailResponse? {
        didSet {
            if let options = menudetail?.options {
                self.options = options
            }
        }
    }
    private var request: String {
        var request = String()
        if let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: CellType.request.rawValue)) as? DeliveryOrderRequestCell, let text = cell.textfield.text {
            request = text
        }
        return request
    }
    
    var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero,
                                collectionViewLayout: UICollectionViewFlowLayout())
    }()
    
    //MARK:- Actions
    @IBAction func tapRecognizerAction(_ sender: Any) {
        if isEditing {
            isEditing = false
            moveCollectionView(toTop: false)            
        }
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let menuInfo = packet as? MenuResponse else {return}
        
        APISource.shared.getMenuDetail(productIndex: menuInfo.index) { res in
            self.menudetail = res
            self.menudetail?.menuInfo.amount = 1
            self.collectionView.reloadSection(section: 0)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        setupFormView()
        setupCollectionView()
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
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.registerNib(DeliveryOrderMenuCell.self)
        collectionView.registerNib(DeliveryOrderOptionCell.self)
        collectionView.registerNib(DeliveryOrderRequestCell.self)
        self.view.addSubview(collectionView)
        collectionView.addAutoLayout(top: self.view.topAnchor,
                                     left: self.view.leftAnchor,
                                     right: self.view.rightAnchor,
                                     bottom: orderSelectorView.topAnchor)
    }
    
    private func setupFormView() {
        deliveryOrderForm = DeliveryOrderForm(delegate: self)
        deliveryOrderForm.onlyCartButton = true
        orderSelectorView = OptionSelectorView(delegate: self)
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
        case menu = 0, options, request
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellType = CellType(rawValue: section) else {
            return 0
        }
        switch cellType {
        case .menu, .request:
            return 1
        case .options:
            return options.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fullSize = collectionView.bounds
        guard let cellType = CellType(rawValue: indexPath.section) else {
            return .zero
        }
        switch cellType {
        case .menu:
            return CGSize(width: fullSize.width, height: fullSize.height*0.45)
        case .options:
            return CGSize(width: fullSize.width, height: 60)
        case .request:
            return CGSize(width: fullSize.width, height: fullSize.height*0.2)
        }
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
                cell.addDivider(on: .bottom, height: 10)
            }
            return cell
        case .options:
            let cell = collectionView.dequeueReusableCell(DeliveryOrderOptionCell.self, for: indexPath)
            cell.delegate = self
            cell.setupView(optionName: options[indexPath.row].name)
            cell.addDivider(on: .bottom)
            return cell
        case .request:
            let cell = collectionView.dequeueReusableCell(DeliveryOrderRequestCell.self, for: indexPath)
            cell.addDivider(on: .bottom)
            cell.delegate = self
            return cell
        }
    }
}

extension DeliveryOrderViewController: DeliveryOrderOptionCellDelegate {
    func optionAmountChanged(indexPath: IndexPath, amount: Int) {
        options[indexPath.row].amount = amount
    }
}

extension DeliveryOrderViewController: OptionSelectorViewDelegate {
    //Menu amount Observer
    func optionSelectorChanged(amount: Int) {
        self.menudetail?.menuInfo.amount = amount
    }
}

extension DeliveryOrderViewController: DeliveryOrderFormDelegate {
    func tapCartButton() {
        guard let menuDetail = menudetail else { return }
        let singleOrder = SingleOrder()
        singleOrder.setProductInfo(productInfo: ProductInfo(menu: menuDetail.menuInfo,
                                                            options: self.options,
                                                            request: request))
        RealmManger.inputData(type: singleOrder)
        DeliveryCommon.shared.navigationController?.pushViewController(storyboard: "Delivery", viewController: DeliveryCartViewController.self)
    }
    
    func tapDirectOrderButton() {
        presentPreparingViewController(target: self)
    }
}

extension DeliveryOrderViewController: DeliveryOrderRequestCellDelegate {
    func onFocused() {
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: CellType.request.rawValue), at: .top, animated: true)
        moveCollectionView(toTop: true)
        self.isEditing = true
    }
    
    fileprivate func moveCollectionView(toTop: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.frame.origin.y = self.collectionView.frame.origin.y + CGFloat(Int(toTop ? -200 : 200))
        }
    }
}
