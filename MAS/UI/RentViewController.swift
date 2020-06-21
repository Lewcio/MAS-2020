//
//  RentViewController.swift
//  MAS
//
//  Created by m.lewandowski on 21/06/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import UIKit

class RentViewController: UIViewController {
    
    var rentedCar: Car?
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
    }
    
    func setupRx() {

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
