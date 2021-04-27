//
//  UIViewController+Extensions.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/26/21.
//

import UIKit

enum AppStoryboard: String {
   case main = "Main"
}

extension UIViewController {
    class func instantiate<T: UIViewController>(appStoryboard: AppStoryboard = .main) -> T {

        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
