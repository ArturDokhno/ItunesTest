//
//  AlertOk.swift
//  ItunesTest
//
//  Created by Артур Дохно on 26.08.2022.
//

import UIKit

extension UIViewController {
    
    func alertOk(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
}
