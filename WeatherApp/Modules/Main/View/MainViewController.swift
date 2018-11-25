//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Назар on 11/12/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit
import OpenWeatherMapKit
import CoreLocation



class MainViewController: UIViewController {
  
  var presenter:ViewToPresenterProtocol?
  let locationManager = CLLocationManager()
  
  
  @IBOutlet weak var collectionView: UICollectionView!
  var cities = [String]()
  var citiesCount: Int = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter?.updateView()
    collectionView.backgroundColor = UIColor.clear
    configureNavigation()
    self.locationManager.requestWhenInUseAuthorization()
 }
  
  func configureNavigation(){
    self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    self.navigationController?.navigationBar.tintColor = UIColor.black
    let locationButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    locationButton.addTarget(self, action: #selector(locationAction), for: .touchUpInside)
    locationButton.setBackgroundImage(UIImage(named: "location"), for: .normal)
    let locationBarItem = UIBarButtonItem(customView: locationButton)
    let currentWidth = locationBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
    currentWidth?.isActive = true
    let currentHeight = locationBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
    currentHeight?.isActive = true
    self.navigationItem.rightBarButtonItem = locationBarItem
  }
  
  @objc func locationAction(sender: UIButton!){
    presenter?.showMap()
  }
}


extension MainViewController: PresenterToViewProtocol{
  func showCells(withCities cities: [String]){
    self.cities = cities
    self.citiesCount = cities.count
    collectionView.reloadData()
  }
  
  func showError(){
    let alert = UIAlertController(title: "Alert", message: "Something goes wrong, please reload app!", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}


extension MainViewController: UICollectionViewDataSource,UICollectionViewDelegate
{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  return citiesCount + 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.item == citiesCount {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCell", for: indexPath) as! MoreCell
      cell.plusImage.image = UIImage(named: "plus")
      cell.layer.cornerRadius = 10
      cell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
      return cell
    }else{
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainWeatherCell
      cell.name.text = cities[indexPath.item]
      cell.layer.cornerRadius = 10
      cell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.item != citiesCount{
    presenter?.shomMore(forCity: cities[indexPath.item])
    }else{
    presenter?.showAddView()
    }
  
  }
}




