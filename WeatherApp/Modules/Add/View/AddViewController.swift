//
//  AddViewController.swift
//  WeatherApp
//
//  Created by Назар on 11/24/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

class AddViewController: UIViewController{
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  var headers = [String]()
  var cities = ["Moscow","London","Lviv","Kiev","Kharkiv","Odessa","Dnipro","Donetsk","Mykolaiv","Vinnytsia","Makiivka","Sumy","Alchevsk","Berdiansk","Chervonohrad","Ivano-Frankivsk"]
  var filterdCities = [String]()
  var presenter: AddViewToPresenterProtocol?
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Choose a city"
    headers = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters.map { String($0) }
    filterdCities = cities
  }
}

extension AddViewController: AddPresenterToViewProtocol{
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchBar.text == ""{
      let count = presenter?.cities(forCharacter: headers[section], forCities: filterdCities).count
      return count!
    }else{
      return filterdCities.count
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell") as! AddCell
    cell.backgroundColor = UIColor.black
    cell.cityLabel.textColor = UIColor.white
    if searchBar.text == ""{
      let city = presenter?.cities(forCharacter: headers[indexPath.section], forCities: filterdCities)
      cell.cityLabel.text = city![indexPath.row]
      return cell
    }else{
      cell.cityLabel.text = filterdCities[indexPath.row]
      return cell
    }
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    if searchBar.text == ""{
      return headers.count
    }else{
      return 1
    }
  }
  func sectionHeaderTitlesForTableView(tableView: UITableView) -> [String]?{
    if searchBar.text == "" {
      return headers
    }else{
      return ["Result:"]
    }
  }
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if searchBar.text == "" {
      return headers[section]
    }else{
      return "Result:"
    }
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! AddCell
    presenter?.showWeather(forCity: cell.cityLabel.text!)
  }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    filterdCities = searchText.isEmpty ? cities : cities.filter({(dataString: String) -> Bool in
      return dataString.range(of: searchText, options: .caseInsensitive) != nil
    })
    print(filterdCities)
    tableView.reloadData()
  }
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
    view.tintColor = #colorLiteral(red: 0.00392069295, green: 0.00392218167, blue: 0.003920496907, alpha: 1)
    let header = view as! UITableViewHeaderFooterView
    header.textLabel?.textColor = UIColor.white
  }
}
