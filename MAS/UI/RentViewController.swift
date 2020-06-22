//
//  RentViewController.swift
//  MAS
//
//  Created by m.lewandowski on 21/06/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class RentViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var rentedCar: Car?
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Finish", for: .normal)
        button.backgroundColor = .redMain
        button.layer.cornerRadius = 12
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupRx()
        
        getCarInfo()
    }
    
    func setupView() {
        view.backgroundColor = .white
        title = "Current rent"
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        view.addSubview(finishButton)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        finishButton.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    func setupRx() {
        
        finishButton.rx.tap.bind { [unowned self] _ in
            if let logged = User.logged, let car = self.rentedCar {
                Rent.endRent(user: logged, car: car)
                self.navigationController?.popViewController(animated: true)
            }
        }.disposed(by: disposeBag)
    }
    
    func getCarInfo() {
        let carTitleLabel = UILabel()
        carTitleLabel.text = rentedCar?.getCarName()
        
        let carRegistrationLabel = UILabel()
        carRegistrationLabel.text = rentedCar?.getRegistrationPlate()
        
        let startDateLabel = UILabel()
        startDateLabel.text = Date().description
        
        stackView.addArrangedSubview(carTitleLabel)
        stackView.addArrangedSubview(carRegistrationLabel)
        stackView.addArrangedSubview(startDateLabel)
    }
}
