//
//  LoginViewController.swift
//  MAS
//
//  Created by m.lewandowski on 21/06/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .blueMain
        textField.textColor = .white
        textField.textAlignment = .center
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 12
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blueDark
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupRx()
    }
    
    func setupView() {
        
        view.backgroundColor = .blueBackground
        
        view.addSubview(emailField)
        view.addSubview(loginButton)
    }
    
    func setupConstraints() {
        
        emailField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    func setupRx() {
        loginButton.rx.tap.bind { [unowned self] _ in
            for user in User.getPersons() {
                if user.email == self.emailField.text {
                    let dashboardVC = DashboardViewController()
                    self.navigationController?.pushViewController(dashboardVC, animated: true)
                    self.navigationController?.viewControllers = [dashboardVC]
                }
            }
        }.disposed(by: disposeBag)
    }
}
