//
//  DashboardViewController.swift
//  MAS
//
//  Created by m.lewandowski on 21/06/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import RxCocoa
import RxSwift

class DashboardViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.layer.cornerRadius = 12
        
        return mapView
    }()
    
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
        
        getCars()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(mapView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
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
    
    func getCars() {
        for car in Car.getAvailableCars() {
            let button = UIButton()
            button.setTitle(car.getCarName(), for: .normal)
            button.backgroundColor = .blueDark
            button.layer.cornerRadius = 12
            
            button.rx.tap.bind { [unowned self] _ in
                // check if car is available
                
                let rentVC = RentViewController()
                rentVC.rentedCar = car
                self.navigationController?.pushViewController(rentVC, animated: true)
                
            }.disposed(by: disposeBag)
            
            stackView.addArrangedSubview(button)
        }
    }
}
