//
//  HomeViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import Alamofire

enum HomeCellType {
    case topAd
    case search
    case menu
    case community
}

class HomeViewController: BaseRootViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var headerAdvertisements: [AdvertiseDto] = []
    private let homeMenuCellViewModel: HomeMenuCellViewModel = {
        return HomeMenuCellViewModel(menuList: StaticLists.getHomeMenuList())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.registerNib(HomeTopAdvertisementCell.self)
        tableView.registerNib(HomeSearchTableViewCell.self)
        tableView.registerNib(HomeMenuCell.self)
        tableView.registerNib(HomeCommunityCell.self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        APISource.shared.getTokenGuest { res in
            UserDefaults.standard.setCustomObject(object: res, key: .accessToken)
            
            let params = [ "deliverySiteIdx": 1 ]
            APISource.shared.getMainall(params: params) { res in
                print(res)
                self.headerAdvertisements = res.advertiseForMainDtoList
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1,2:
            return 1//fix
        case 3:
            return 1//community count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UIScreen.main.bounds.size.height * 0.45
        case 1:
            return 50
        case 2:
            return UIScreen.main.bounds.size.height * 0.15
        case 3:
            return 30 * 1 //community count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(HomeTopAdvertisementCell.self, for: indexPath)
            //cell.setupView(model: <#T##HomeTopAdvertisementCellViewModel#>)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(HomeSearchTableViewCell.self, for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(HomeMenuCell.self, for: indexPath)
            cell.setupView(model: homeMenuCellViewModel)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(HomeCommunityCell.self, for: indexPath)
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    
}
