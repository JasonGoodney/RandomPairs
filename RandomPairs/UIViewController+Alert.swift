//
//  UIViewController+Alert.swift
//  RandomPairs
//
//  Created by Jason Goodney on 11/16/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAddPersonAlert(withTitle title: String, message: String, completion: @escaping (Person?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text else {
                completion(nil); return
            }
            let person = Person(name: name)
            completion(person)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        [okAction, cancelAction].forEach { alertController.addAction($0) }
        
        present(alertController, animated: true, completion: nil)
        
    }
}
