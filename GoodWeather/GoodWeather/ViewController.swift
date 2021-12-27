//
//  ViewController.swift
//  GoodWeather
//
//  Created by 강호성 on 2021/12/14.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
    }

    // MARK: - Helper
    
    private func populateData() {
        
        /*self.cityNameTextField.rx.value
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)*/
        
        // textField에 입력이 끝나면 요청
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.cityNameTextField.text }
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp) ℉"
            self.humidityLabel.text = "\(weather.humidity) 💦"
        } else {
            self.temperatureLabel.text = "💁‍♂️"
            self.humidityLabel.text = "💦"
        }
    }
    
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        
        let resource = Resource<WeatherResult>(url: url)
        
        /*URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance) // DispatchQueue.main.async
            .catchAndReturn(WeatherResult.empty) // do catch
            .subscribe(onNext: { result in
                let weather = result.main
                self.displayWeather(weather)
            }).disposed(by: disposeBag)*/
        
        
        // MARK: - Map
        
        /*let search = URLRequest.load(resource: resource)
                    .observe(on: MainScheduler.instance)
                    .catchAndReturn(WeatherResult.empty)*/
        
        //bind를 사용하여 데이터에서 옵저버블을 바인딩하고, 데이터를 가져와 화면에 바인딩
        /*search.map {"\($0.main.temp) ℉"}
        .bind(to: self.temperatureLabel.rx.text)
        .disposed(by: disposeBag)
        
        search.map {"\($0.main.humidity) 💦"}
        .bind(to: self.humidityLabel.rx.text)
        .disposed(by: disposeBag)*/
        
        
        // MARK: - Drive
        
       /* let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance) // DispatchQueue.main.async
            .asDriver(onErrorJustReturn: WeatherResult.empty)*/
        
        // Handle Errors with Catch
        let search = URLRequest.load(resource: resource)
            .retry(3) // Retrying on Error
            .observe(on: MainScheduler.instance)
            .catch { error in
                print(error.localizedDescription)
                return Observable.just(WeatherResult.empty)
            }.asDriver(onErrorJustReturn: WeatherResult.empty)
        

        // drive
        search.map {"\($0.main.temp) ℉"}
        .drive(self.temperatureLabel.rx.text)
        .disposed(by: disposeBag)
        
        search.map {"\($0.main.humidity) 💦"}
        .drive(self.humidityLabel.rx.text)
        .disposed(by: disposeBag)
        
    }
}

