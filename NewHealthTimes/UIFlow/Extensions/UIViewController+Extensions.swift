//
//  UIViewController+Extensions.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/26/21.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

extension UIViewController {
    func showSomethingWentWrongAlert(title: String? = nil, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: NSLocalizedString(title ?? "Something went wrong",
                                                               comment: title ?? "Something went wrong"),
                                      message: NSLocalizedString(message ?? "Please try again in a bit.",
                                                                 comment: message ?? "Please try again in a bit."),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"),
                                      style: .default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
}
