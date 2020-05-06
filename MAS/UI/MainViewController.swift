//
//  MainViewController.swift
//  MAS
//
//  Created by m.lewandowski on 06/05/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel()
        let subtitle = UILabel()
        
        
        view.backgroundColor = .red
        title.textColor = .white
        subtitle.textColor = .white
        title.text = "Wypożyczalnia samochodów"
        subtitle.text = "MAS s13864"
        
        view.addSubview(title)
        view.addSubview(subtitle)
        
        title.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }


}

