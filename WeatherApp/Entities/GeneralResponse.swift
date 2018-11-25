//
//  GeneralResponse.swift
//  WeatherApp
//
//  Created by Назар on 11/22/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation

struct GeneralResponse: Decodable {
  var list: [General]
  var city: AboutCity
}
