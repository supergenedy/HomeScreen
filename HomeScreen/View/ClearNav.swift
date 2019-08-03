//
//  ClearNav.swift
//  HomeScreen
//
//  Created by Ahmed on 8/3/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import Foundation
import UIKit

struct ClearNav {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }
}
