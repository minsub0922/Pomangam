///
//  DeliveryViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 17/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryMenuListViewController: BaseViewController {
    //MARK: Properties
    private var navigationButtonView: NavigationTitleDropDownButton = NavigationTitleDropDownButton()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var marketDetail: DeliveryMarket!
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addDeliveryMenuListScrollObserver()
    }
    
    //MARK
    override func setPacket(packet: BaseViewController.Packet) {
        guard let marketDetail = packet as? DeliveryMarket else {return}
        self.marketDetail = marketDetail
        CurrentMarket.shared.index = marketDetail.index
    }
    
    private func setupUI() {
        navigationButtonView.addTarget(self, action: #selector(navigationTitleTapAction(_:)), for: .touchUpInside)
        navigationButtonView.configure("학생회관 뒤")
        let rightButton = UIBarButtonItem(image: UIImage(named: "btnDeliveryFilter"), style: .plain, target: self, action: #selector(navigationRightButtonTapAction(_:)))
        
        navigationItem.titleView = navigationButtonView
        navigationItem.rightBarButtonItem  = rightButton
        navigationController?.navigationBar.backgroundColor = .white
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.registerNib(DeliveryMenuListHeaderCell.self)
        collectionView.registerNib(DeliveryTabpagerCell.self)
        self.view.addSubview(collectionView)
        collectionView.addAutoLayout(parent: self.view)
    }
    
    private func addDeliveryMenuListScrollObserver() {
        NotificationCenter.default.addObserver(
            target: self,
            notificationName: .deliveryMenuListScrolled,
            selector: #selector(deliveryMenuListScrolledAction(_:)))
    }
    
    @objc private func navigationRightButtonTapAction(_ sender: Any) {
        print("tapped Right Button")
    }
    
    @objc private func navigationTitleTapAction(_ sender: Any) {
        print("touched??")
    }
    
    @objc private func deliveryMenuListScrolledAction(_ notification: Notification) {
        guard let info = notification.scrollDetail else { return }
        print("i gotya! \(info.y)")
        let origin = collectionView.frame.origin
        
//        collectionView.frame = CGRect(
//            x: origin.x,
//            y: info.y > 0 ? origin.y+1 : origin.y-1,
//            width: collectionView.bounds.width,
//            height: collectionView.bounds.height)
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
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height * 0.17)
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
            cell.setupView(model: marketDetail.asDeliveryMenuListHeaderViewModel)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(DeliveryTabpagerCell.self, for: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
