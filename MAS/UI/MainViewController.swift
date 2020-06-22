//
//  MainViewController.swift
//  MAS
//
//  Created by m.lewandowski on 17/04/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel()
        let subtitle = UILabel()
        
        
        view.backgroundColor = .redBackground
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
        
        addCars()
        addUsers()
        
        setupView()
        
        // trwałość ekstensji
        print(Person.getPersons())
        
        // make Pan Swiata employee also user
        for user in User.getPersons() {
            if user.name == "Pan", user.surname == "Swiata" {
                user.makeUser()
                
                // should be now .employee and .user
                print(user.type)

                
                // make user Micha Lewandowski possible to rent a car
                for verify in User.getPersons() {
                    if verify.name == "Michal", verify.surname == "Lewandowski" {
                        user.verifyUser(user: verify)
                    }
                }
            }
        }
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
        
        let button1 = UIButton()
        button1.setTitle("Login", for: .normal)
        button1.backgroundColor = .redDark
        button1.layer.cornerRadius = 12
        button1.rx.tap.bind { [weak self] _ in
            let loginVC = LoginViewController()
            self?.navigationController?.pushViewController(loginVC, animated: true)
        }.disposed(by: disposeBag)
        
        let button2 = UIButton()
        button2.setTitle("Create account", for: .normal)
        button2.backgroundColor = .redDark
        button2.layer.cornerRadius = 12
        button2.rx.tap.bind { [weak self] _ in
            let loginVC = LoginViewController()
            self?.navigationController?.pushViewController(loginVC, animated: true)
        }.disposed(by: disposeBag)
        
        view.addSubview(button1)
        button1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        view.addSubview(button2)
        button2.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(button1.snp.bottom).offset(20)
        }
    }
    
    func addCars() {
        let car1 = Car(
            brand: "BMW",
            model: "1 series",
            registrationPlate: "WE 10000",
            engine: Engine.getEngine(power: 140, gearbox: .manual)
        )
        let car2 = Car(
            brand: "BMW",
            model: "1 series",
            registrationPlate: "WE 10001",
            engine: Engine.getEngine(power: 140, gearbox: .automatic)
        )
        let car3 = Car(
            brand: "Ford",
            model: "Focus",
            registrationPlate: "WB 12345",
            engine: Engine.getEngine(power: 110, gearbox: .manual)
        )
        Car.addCar(car1)
        Car.addCar(car2)
        Car.addCar(car3)
        self.addInsurance(to: car1, expires: Date(timeIntervalSinceNow: 1000))
        self.addInsurance(to: car3, expires: Date(timeIntervalSinceNow: 1000))
    }
    
    func addUsers() {
        let _ = Person(name: "Bogdan", surname: "Niemiecki", email: "b.nie@abc.pl", address: "Warszawa, Pulawska 1", phoneNumber: 600200300, type: .user)
        let _ = Person(name: "Tomasz", surname: "Aleksander", email: "ta@abc.pl", address: "Warszawa, Grochowska 3", phoneNumber: 600200301, type: .user)
        let _ = Person(name: "Pan", surname: "Swiata", email: "rarri@cars.com", address: "Italy, Mozna", phoneNumber: 612332632, type: .employee)
        let _ = Person(name: "Michal", surname: "Lewandowski", email: "s13864@pjwstk.edu.pl", address: "Warszawa, Koszykowa 1", phoneNumber: 600100300, type: .user)
    }
    
    func addInsurance(to car: Car, expires: Date) {
        let _ = Insurance(car: car, expires: expires)
    }


}

