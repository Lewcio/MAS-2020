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
        
        setupView()
        
        addCars()
        addUsers()
        
        // trwałość ekstensji
        print(User.getUsers())
        
    }
    
    func setupView() {
        let logged = User(id: 3, firstName: "Michal", secondName: "Lewandowski", email: "s13864@pjwstk.edu.pl", address: "Warszawa, Koszykowa 1", phoneNumber: 600100300)
        
        let button1 = UIButton()
        button1.setTitle("Rent car1 (WE 10000)", for: .normal)
        button1.backgroundColor = .systemGreen
        button1.layer.cornerRadius = 12
        button1.rx.tap.bind { _ in
            // car that user want to rent
            if let car = Car.getCar(registrationPlate: "WE 10000") {
                // check if its possible to rent the car
                if Rent.canRent(car: car) {
                    Rent.rent(user: logged, car: car)
                    let alert = UIAlertController(title: "You have rented a car", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Thank you", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Car is currently unavileable", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }.disposed(by: disposeBag)
        
        let button2 = UIButton()
        button2.setTitle("Stop renting", for: .normal)
        button2.backgroundColor = .systemGreen
        button2.layer.cornerRadius = 12
        button2.rx.tap.bind { _ in
            if let rent = Rent.currentRent(by: logged) {
                Rent.endRent(user: logged, car: rent.car)
                let alert = UIAlertController(title: "You have ended your rent", message: "Thank you!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "You have no rented car", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }.disposed(by: disposeBag)
        
        let button3 = UIButton()
        button3.setTitle("Add inurance to car (WE 10000) for 7 seconds", for: .normal)
        button3.backgroundColor = .systemGreen
        button3.layer.cornerRadius = 12
        button3.rx.tap.bind { [unowned self] _ in
            if let car = Car.getCar(registrationPlate: "WE 10000") {
                self.addInsurance(to: car, expires: Date(timeIntervalSinceNow: 7))
            }
        }.disposed(by: disposeBag)
        
        view.addSubview(button1)
        button1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(button2)
        button2.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(button1.snp.bottom).offset(20)
        }
        
        view.addSubview(button3)
        button3.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(button2.snp.bottom).offset(20)
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
        Car.addCar(car1)
        Car.addCar(car2)
    }
    
    func addUsers() {
        let _ = User(id: 1, firstName: "Bogdan", secondName: "Niemiecki", email: "b.nie@abc.pl", address: "Warszawa, Pulawska 1", phoneNumber: 600200300)
        let _ = User(id: 2, firstName: "Tomasz", secondName: "Aleksander", email: "ta@abc.pl", address: "Warszawa, Grochowska 3", phoneNumber: 600200301)
    }
    
    func addInsurance(to car: Car, expires: Date) {
        let _ = Insurance(car: car, expires: expires)
    }


}

