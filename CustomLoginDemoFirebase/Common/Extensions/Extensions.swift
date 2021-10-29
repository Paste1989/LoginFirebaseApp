//
//  CustomTextfield.swift
//  CustomLoginDemoFirebase
//
//  Created by Saša Brezovac on 28.10.2021..
//

import Foundation
import UIKit

extension UITextField {
    func styleTextField() {
        let bottomLine = UIView()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 250, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        self.addSubview(bottomLine)
        self.borderStyle = .none
        
    }
}

extension UIButton {
    func styleFilledButton() {
        self.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        self.layer.cornerRadius = 25.0
        self.tintColor = UIColor.white
    }
    
    func styleHollowButton() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        self.layer.cornerRadius = 25.0
        self.tintColor = UIColor.black
    }
}

extension UIViewController {
    func showMessage(title: String?, messagae: String) {
        let alert = UIAlertController(title: title, message: messagae, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
