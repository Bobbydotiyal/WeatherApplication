//
//  WeatherViewModel.swift
//  DemoProject
//
//  Created by Newmac on 28/06/23.
//

import Foundation
import CoreData
import UIKit

class WeatherViewModel {
    
    var weatherData: WeatherDataModel?
    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    //MARK:- Function for Api calling
    func getData(for cityName: String, completion: @escaping (Bool, String?) -> Void) {
        ApiHandler.getApi(responseType: WeatherDataModel.self, city: cityName) { [weak self] dataResponse, message in
            DispatchQueue.main.async {
                if let dataResponse = dataResponse {
                    self?.weatherData = dataResponse
                    self?.saveLastSearchedCity(city: cityName)
                    completion(true, nil)
                } else {
                    completion(false, message)
                }
            }
        }
    }
    
    //MARK:- Save Last Searched City Using Coredata
    func saveLastSearchedCity(city: String) {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            if let cityEntity = result.first {
                cityEntity.name = city
            } else {
                let cityEntity = City(context: context)
                cityEntity.name = city
            }
            try context.save()
        } catch {
            print("Failed to save city: \(error)")
        }
    }
    
    //MARK:- Load Last Searched City Using Coredata
    func loadLastSearchedCity(completion: @escaping (String?) -> Void) {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            if let lastCity = result.first?.name {
                completion(lastCity)
            
            } else {
                completion(nil)
            }
        } catch {
            print("Failed to load last searched city: \(error)")
            completion(nil)
        }
    }
    
}/// Class ends
