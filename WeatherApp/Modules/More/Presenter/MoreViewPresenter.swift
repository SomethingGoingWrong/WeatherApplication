//
//  MoreViewPresenter.swift
//  WeatherApp
//
//  Created by Назар on 11/21/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class MoreViewPresenter: MoreViewToPresenterProtocol {
  var view: MorePresenterToViewProtocol?
  var interactor: MorePresenterToInteractorProtocol?
  var router: MorePresenterToRouterProtocol?
  
  func updateView(withCity city: String,withDay day: Int){
    interactor?.getWeather(withCity: city, withDay: day)
  }
  func updateCells(withCity city: String, withCell cell: WeatherCell, withIndxPath indexPath: IndexPath){
    interactor?.getCellsData(withCity: city, withIndexPath: indexPath, withCell: cell)
  }
  func updateCellsByCoordinates(withCoordinates coordinates: CLLocationCoordinate2D, withCell cell: WeatherCell, withIndxPath indexPath: IndexPath){
    interactor?.getCellsData(withCoordinates: coordinates, withIndexPath: indexPath, withCell: cell)
  }
  func updateViewByCoordinates(withCoordinates coordinates: CLLocationCoordinate2D,withDay day: Int){
    interactor?.getWeatherByLocation(withCoordinates: coordinates, withDay: day)
  }
  func checkIfCitySaved(withCity city: String) -> Bool{
    return (interactor?.checkIfCitySaved(withCity: city))!
  }
  func deleteCity(forCity city: String){
    interactor?.deleteCity(forCity: city)
  }
  func addCity(forCity city: String){
    interactor?.addCity(forCity: city)
  }
  func presentMainView(){
    router?.presentMainViewController(from: view as! MoreViewController)
  }
}

extension MoreViewPresenter: MoreInteractorToPresenterProtocol{
  func weatherGoted(withWeather weather: GeneralResponse,withDay day: Int){
    view?.showWeather(withWeather: weather, withDay: day)
  }
  func failWithGettingWeather(){
    view?.showError()
  }
  func cellsDataGoted(withWeather weather: GeneralResponse,withCells cells: WeatherCell,withIndexPath indexPath: IndexPath){
    view?.configureCells(withWeather: weather, withCell: cells, withIndexPath: indexPath)
  }
}
