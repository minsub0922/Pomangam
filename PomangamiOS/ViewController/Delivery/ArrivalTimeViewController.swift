//
//  ArrivalTimeViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/10/27.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class ArrivalTimeViewController: BaseViewController {
    @IBAction func touchupApplyButton(_ sender: Any) {
    }
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeStateLabel: UILabel!
    @IBOutlet weak var deliveryStateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    fileprivate var availableTimes: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ArrivalTimeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ArrivalTimeCell.self)
        
        return cell
    }
}

class ArrivalTimeCell: UITableViewCell {
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    required init?(coder: NSCoder) {
       super.init(coder: coder)
       
       let backgroundView = UIView()
       backgroundView.backgroundColor = UIColor.dustyOrange.withAlphaComponent(0.05)
       self.selectedBackgroundView = backgroundView
   }
}
