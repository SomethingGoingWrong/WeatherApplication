//
//  General.swift
//  WeatherApp
//
//  Created by Назар on 11/7/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation

struct General: Decodable {
  //let coord: Coord
  let weather: [Weather]
  //let base: String
  let main: Main
  //let visibility: Int
  let wind: Wind
  let clouds: Clouds
  let dt: Int
  //let sys: Sys
}
