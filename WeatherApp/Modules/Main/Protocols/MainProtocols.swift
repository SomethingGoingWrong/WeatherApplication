//
//  Mainprotocols.swift
//  WeatherApp
//
//  Created by Назар on 11/12/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
  var view: PresenterToViewProtocol? {get set}
  var interactor: PresenterToInteractorProtocol? {get set}
  var router: PresenterToRouterProtocol? {get set}
  func updateView()
  func shomMore(forCity city: String)
  func showMap()
  func showAddView()
}

protocol PresenterToViewProtocol: class{
  func showCells(withCities cities: [String])
  func showError()
}

protocol PresenterToRouterProtocol: class {
func presentMoreViewController(from view: MainViewController, forCity city: String)
func presentMapViewController(from view: MainViewController)
func presentAddViewController(from view: MainViewController)
static func presentMainModule() -> UIViewController 
}

protocol PresenterToInteractorProtocol: class {
 var presenter:InteractorToPresenterProtocol? {get set}
 func getCitiesNames()
}

protocol InteractorToPresenterProtocol: class {
  func citiesNamesGoted(cities: [String])
  func citiesNamesGotedFail()
}

