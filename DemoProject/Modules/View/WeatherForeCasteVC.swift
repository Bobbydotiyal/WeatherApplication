//
//  WeatherForeCasteVC.swift
//  DemoProject
//
//  Created by Newmac on 28/06/23.
//

import UIKit

class WeatherForeCasteVC: UIViewController {
    @IBOutlet weak var txtEnterCity: UITextField!
    @IBOutlet weak var lblTemprature: UILabel!
    @IBOutlet weak var lblWeatherDiscription: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var btnFetchWeather: UIButton!
    
    
    lazy var viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLastSearchedCity()
        CornerRadiusHelper.applyCornerRadius(10, to: txtEnterCity, btnFetchWeather)
    }
    
    //MARK: Button Action
    @IBAction func btnFetchWeatherTapped(_ sender: Any) {
        checkNetworkConnectivity()
    }
    
    //MARK:- Api Calling
    func getApiData() {
        guard let cityName = txtEnterCity.text, !cityName.isEmpty else {
            return
        }
        viewModel.getData(for: cityName) { [weak self] success, message in
            guard let self = self else { return }
            if success {
                DispatchQueue.main.async {
                    
                    if let weatherData = self.viewModel.weatherData,
                       let temp = weatherData.current?.tempC,
                       let humidity = weatherData.current?.humidity,
                       let windSpeed = weatherData.current?.windKph,
                       let weatherDis = weatherData.current?.condition.text {
                        self.lblTemprature.text = "Temperature: \(temp)°C"
                        self.lblWeatherDiscription.text = "Weather: \(weatherDis)"
                        self.lblHumidity.text = "Humidity: \(humidity)%"
                        self.lblWindSpeed.text = "Wind speed: \(windSpeed) km/h"
                    }
                }
            } else {
                self.showAlert(title: "Error", message: message ?? "Failed to fetch weather data")
            }
        }
    }
    
    //MARK:- Load Last Searched City
    func loadLastSearchedCity() {
        viewModel.loadLastSearchedCity { [weak self] city in
            guard let self = self else { return }
            if let city = city {
                self.txtEnterCity.text = city
                self.getApiData()
            }
        }
    }
    
    //MARK:- Alert Action
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Check Network Connectivity
    func checkNetworkConnectivity() {
        if NetworkManager.shared.isNetworkAvailable() {
            guard let city = txtEnterCity.text, !city.isEmpty else {
                showAlert(title: "", message: "Please enter city")
                return
            }
            getApiData()
        } else {
            showAlert(title: "Alert", message: "Network is not available")
        }
    }
}




