//
//  MoreViewController.swift
//  WeatherApp
//
//  Created by Назар on 11/21/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import CoreLocation

class MoreViewController: UIViewController {
  var presenter: MoreViewToPresenterProtocol?
  @IBOutlet weak var mainLabel: UIImageView!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var humidityImage: UIImageView!
  @IBOutlet weak var windImage: UIImageView!
  @IBOutlet weak var cloudnesImage: UIImageView!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var cloudnesLabel: UILabel!
  @IBOutlet weak var windLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
  var city: String?
  var location: CLLocationCoordinate2D?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    self.navigationController?.navigationBar.tintColor = UIColor.black
    collectionView.allowsMultipleSelection = false
    collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .bottom)
    
    let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    backButton.addTarget(self, action: #selector(returnToMainView), for: .touchUpInside)
    backButton.setBackgroundImage(UIImage(named: "return"), for: .normal)
    let backBarItem = UIBarButtonItem(customView: backButton)
    let currentWidth = backBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
    currentWidth?.isActive = true
    let currentHeight = backBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
    currentHeight?.isActive = true
    self.navigationItem.leftBarButtonItem = backBarItem
    
    activityIndicator.hidesWhenStopped = true
    activityIndicator.center = view.center
    activityIndicator.startAnimating()
    
    if city != nil{
      presenter?.updateView(withCity: city!, withDay: 0)
    }else{
      presenter?.updateViewByCoordinates(withCoordinates: location!, withDay: 0)
    }
  }
  
   @objc func cityAction(sender: UIButton!){
    if (presenter?.checkIfCitySaved(withCity: self.title!))!{
      presenter?.deleteCity(forCity: self.title!)
      sender.setBackgroundImage(UIImage(named: "add"), for: .normal)
    }else{
      presenter?.addCity(forCity: self.title!)
      sender.setBackgroundImage(UIImage(named: "remove"), for: .normal)
    }
  }
  @objc func returnToMainView(sender: UIButton!){
    presenter?.presentMainView()
  }
}

extension MoreViewController: MorePresenterToViewProtocol {
  func showWeather(withWeather weather:GeneralResponse, withDay day: Int){
    //day is number of days array (from 0 to 4)
    mainLabel.kf.setImage(with: URL(string: "http://openweathermap.org/img/w/\(weather.list[day + 8 * day].weather[0].icon).png"))
    tempLabel.text = "\(String(Float(weather.list[8 * day].main.temp - 273))) °C"
    humidityImage.image = UIImage(named: "humidity")
    windImage.image = UIImage(named: "wind")
    cloudnesImage.image = UIImage(named: "clouds")
    humidityLabel.text = "\(weather.list[8 * day].main.humidity) %"
    windLabel.text = "\(weather.list[8 * day].wind.speed) m/s"
    cloudnesLabel.text = "\(weather.list[8 * day].clouds.all) %"
    self.title = weather.city.name
    let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    addButton.addTarget(self, action: #selector(cityAction), for: .touchUpInside)
    let addBarItem = UIBarButtonItem(customView: addButton)
    let currentWidth = addBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
    currentWidth?.isActive = true
    let currentHeight = addBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
    currentHeight?.isActive = true
    self.navigationItem.rightBarButtonItem = addBarItem
    if (presenter?.checkIfCitySaved(withCity: self.title!))!{
      addButton.setBackgroundImage(UIImage(named: "remove"), for: .normal)
    }else{
      addButton.setBackgroundImage(UIImage(named: "add"), for: .normal)
    }
  }
  
  func configureCells(withWeather weather: GeneralResponse, withCell cell: WeatherCell,withIndexPath indexPath: IndexPath){
    let date = Calendar.current.date(byAdding: .day, value: Int(indexPath.item), to: Date())
    cell.dataLabel.text = date?.toString(dateFormat: "dd")
    cell.weatherLabel.text = "\(String(Int(weather.list[8 * indexPath.item].main.temp - 273))) °C"
    cell.iconImage.kf.setImage(with: URL(string: "http://openweathermap.org/img/w/\(weather.list[8 * (indexPath.item)].weather[0].icon).png"))
  }
  
  func showError(){
    let alert = UIAlertController(title: "Alert", message: "Problem with network conection!", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}

extension MoreViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
    if city != nil{
      presenter?.updateCells(withCity: city!, withCell: cell, withIndxPath: indexPath)
    }else{
      presenter?.updateCellsByCoordinates(withCoordinates: location!, withCell: cell, withIndxPath: indexPath)
    }
    cell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    return cell
  }
  func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenSize = UIScreen.main.bounds
    let screenWidth = screenSize.width
    return CGSize(width: screenWidth/5, height: 130);
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as? WeatherCell
    cell?.backgroundColor = UIColor.black
    cell?.dataLabel.textColor = UIColor.white
    cell?.weatherLabel.textColor = UIColor.white
    if city != nil{
      presenter?.updateView(withCity: city!, withDay: indexPath.item)
    }else{
      presenter?.updateViewByCoordinates(withCoordinates: location!, withDay: indexPath.item)
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
      let cell = collectionView.cellForItem(at: indexPath) as? WeatherCell
      cell?.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
      cell?.dataLabel.textColor = UIColor.black
      cell?.weatherLabel.textColor = UIColor.black
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let index = IndexPath(item: 0, section: 0)
    if indexPath == index{
      let cell = cell as? WeatherCell
      cell!.backgroundColor = UIColor.black
      cell!.weatherLabel.textColor = UIColor.white
      cell!.dataLabel.textColor = UIColor.white
    }
    if let lastVisibleIndexPath = collectionView.indexPathsForVisibleItems.last{
      if indexPath == lastVisibleIndexPath{
        activityIndicator.stopAnimating()
      }
    }
  }
}


