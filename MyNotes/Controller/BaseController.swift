//
//  BaseController.swift
//  MyNotes
//
//  Created by Eswar venigalla on 12/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.loadNavigationControllerInNormalMode()
   }
   func loadNavigationControllerInNormalMode(){
      self.navigationController?.navigationBar.barTintColor = UIColor.init(red: CGFloat(224.0/255.0), green: CGFloat(101.0/255.0), blue: CGFloat(72.0/255.0), alpha: 1)
      if let navFont = UIFont(name: "Avenir", size: 18) {
         let navBarAttributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.init(white: 1, alpha: 0.8),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): navFont ]
         UINavigationBar.appearance().titleTextAttributes = navBarAttributesDictionary
         self.navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
      }
   }
}

