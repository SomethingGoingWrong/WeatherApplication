//
//  UIViewController.swift
//  WeatherApp
//
//  Created by Назар on 11/23/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  func navigated<T: UINavigationController>(_ navigationControllerClass: T.Type) -> T {
    return T(rootViewController: self)
  }
}
