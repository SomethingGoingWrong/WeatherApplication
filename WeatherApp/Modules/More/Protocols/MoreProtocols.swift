//
//  MoreProtocols.swift
//  WeatherApp
//
//  Created by Назар on 11/21/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol MoreViewToPresenterProtocol: class {
  var view: MorePresenterToViewProtocol? {get set}
  var interactor: MorePresenterToInteractorProtocol? {get set}
  var router: MorePresenterToRouterProtocol? {get set}
  func updateView(withCity city: String,withDay day: Int)
  func updateCells(withCity city: String, withCell cell: WeatherCell, withIndxPath indexPath: IndexPath)
  func updateCellsByCoordinates(withCoordinates coordinates: CLLocationCoordinate2D, withCell cell: WeatherCell, withIndxPath indexPath: IndexPath)
  func updateViewByCoordinates(withCoordinates coordinates: CLLocationCoordinate2D,withDay day: Int)
  func checkIfCitySaved(withCity city: String) -> Bool
  func deleteCity(forCity city: String)
  func addCity(forCity city: String)
  func presentMainView()
}

protocol MorePresenterToViewProtocol: class {
  func showWeather(withWeather weather: GeneralResponse, withDay day: Int)
  func showError()
  func configureCells(withWeather weather: GeneralResponse, withCell cell: WeatherCell,withIndexPath indexPath: IndexPath)
}

protocol MorePresenterToRouterProtocol: class {
   static func createMoreModule(forCity city: String) -> UIViewController
   static func createMoreModuleByCoordinates(forCoordinates coordinates: CLLocationCoordinate2D) -> UIViewController
   func presentMainViewController(from view: MoreViewController)
}

protocol MorePresenterToInteractorProtocol {
  var presenter: MoreInteractorToPresenterProtocol? {get set}
  var apiService: ApiServiceProtocol? {get set}
  func getWeather(withCity city: String,withDay day: Int)
  func getCellsData(withCity city: String, withIndexPath indexPath: IndexPath, withCell cell:WeatherCell)
  func getWeatherByLocation(withCoordinates coordinates: CLLocationCoordinate2D, withDay day: Int)
  func getCellsData(withCoordinates coordinate: CLLocationCoordinate2D, withIndexPath indexPath: IndexPath, withCell cell:WeatherCell)
  func checkIfCitySaved(withCity city: String) -> Bool
  func deleteCity(forCity city: String)
  func addCity(forCity city: String)
}

protocol MoreInteractorToPresenterProtocol: class {
  func weatherGoted(withWeather weather: GeneralResponse,withDay day: Int)
  func failWithGettingWeather()
  func cellsDataGoted(withWeather weather: GeneralResponse,withCells cells: WeatherCell,withIndexPath indexPath: IndexPath)
}

