//
//  DeliveryTempViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/11/12.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import WebKit

class DeliveryTempViewController: UIViewController {
    private let wkWebview: WKWebView = {
        return WKWebView(frame: .zero, configuration: .init())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(wkWebview)
        wkWebview.addAutoLayout(parent: self.view)
        wkWebview.load(URLRequest(url: URL(string: "https://www.pomangam.com/tmain.do?idx=1")!))
    }
}
