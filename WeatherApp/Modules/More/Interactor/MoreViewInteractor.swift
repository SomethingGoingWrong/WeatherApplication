//
//  MoreViewInteractor.swift
//  WeatherApp
//
//  Created by Назар on 11/21/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class MoreViewInteractor: MorePresenterToInteractorProtocol{
  var presenter: MoreInteractorToPresenterProtocol?
  var apiService: ApiServiceProtocol?
  var storageService: StorageServicesProtocol?
  
  func getWeather(withCity city: String,withDay day: Int){
    apiService?.getWeathers(withCity: city, success: { (result) in
      self.presenter?.weatherGoted(withWeather: result, withDay: day)
    }, failure: { (error) in
      self.presenter?.failWithGettingWeather()
    })
  }
  func getCellsData(withCity city: String, withIndexPath indexPath: IndexPath, withCell cell:WeatherCell){
    apiService?.getWeathers(withCity: city, success: { (result) in
      self.presenter?.cellsDataGoted(withWeather: result, withCells: cell, withIndexPath: indexPath)
    }, failure: { (error) in
      self.presenter?.failWithGettingWeather()
    })
  }
  
  func getWeatherByLocation(withCoordinates coordinates: CLLocationCoordinate2D, withDay day: Int){
    apiService?.getWeatherByCoordinates(withCoordinates: coordinates, success: { (result) in
      self.presenter?.weatherGoted(withWeather: result, withDay: day)
    }, failure: { (error) in
      self.presenter?.failWithGettingWeather()
    })
  }
  func getCellsData(withCoordinates coordinate: CLLocationCoordinate2D, withIndexPath indexPath: IndexPath, withCell cell:WeatherCell){
    apiService?.getWeatherByCoordinates(withCoordinates: coordinate, success: { (result) in
      self.presenter?.cellsDataGoted(withWeather: result, withCells: cell, withIndexPath: indexPath)
    }, failure: { (error) in
      self.presenter?.failWithGettingWeather()
    })
  }
  func checkIfCitySaved(withCity city: String) -> Bool {
    let cities = storageService?.savedCitiesNames()
    var c = City()
    c.name = city
    return (cities?.contains(c.name))!
  }
  func deleteCity(forCity city: String){
    storageService?.deleteCity(forCity: city)
  }
  func addCity(forCity city: String){
    storageService?.addCity(forCity: city)
}
}
