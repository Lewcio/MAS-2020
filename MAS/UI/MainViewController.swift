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
        
        addCars()
        addUsers()
        
        let logged = User(id: 3, firstName: "Michal", secondName: "Lewandowski", email: "s13864@pjwstk.edu.pl", address: "Warszawa, Koszykowa 1", phoneNumber: 600100300)
        User.addUser(logged)
        
        // trwałość ekstensji
        print(User.getUsers())
        
        
        let button1 = UIButton()
        button1.setTitle("Rent car1", for: .normal)
        button1.rx.tap.bind {_ in
            if let car = Car.getCar(registrationPlate: "WE 10000") {
                if car.isRented() {
                    let alert = UIAlertController(title: "Car is currently rented", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    car.rent(by: logged)
                    let alert = UIAlertController(title: "You have rented a car", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Thank you", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }.disposed(by: disposeBag)
        
        let button2 = UIButton()
        button2.setTitle("Stop renting car1", for: .normal)
        button2.rx.tap.bind {_ in
            if let car = Car.getCar(registrationPlate: "WE 10000") {
                if car.isRented() {
                    car.finishRent()
                    let alert = UIAlertController(title: "You have ended your rent", message: "Thank you!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Car isn't rented", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }.disposed(by: disposeBag)
        
        view.addSubview(button1)
        button1.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(button2)
        button2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
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
        Car.addCar(car1)
        let car2 = Car(
            brand: "BMW",
            model: "1 series",
            registrationPlate: "WE 10001",
            engine: Engine.getEngine(power: 140, gearbox: .automatic)
        )
        Car.addCar(car2)
    }
    
    func addUsers() {
        let user1 = User(id: 1, firstName: "Bogdan", secondName: "Niemiecki", email: "b.nie@abc.pl", address: "Warszawa, Pulawska 1", phoneNumber: 600200300)
        User.addUser(user1)
        let user2 = User(id: 2, firstName: "Tomasz", secondName: "Aleksander", email: "ta@abc.pl", address: "Warszawa, Grochowska 3", phoneNumber: 600200301)
        User.addUser(user2)
    }


}

