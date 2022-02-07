//
//  Alerts.swift
//  showMovieApp
//
//  Created by Nikolay T on 31.01.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func alertError (title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertOk = UIAlertAction(title: "OK", style: .default) { action in
            
        }
        
        alertController.addAction(alertOk)
        
        present(alertController, animated: true, completion: nil)
    }
}
