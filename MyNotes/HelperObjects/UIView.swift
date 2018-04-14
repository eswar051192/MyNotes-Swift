//
//  UIView.swift
//  MyNotes
//
//  Created by Eswar venigalla on 12/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
   func creatCorner(backgroundColor : UIColor,borderColor : UIColor, borderWidth : CGFloat = CGFloat(1.0)){
      self.layer.cornerRadius = CGFloat(Double(self.frame.size.height / 2.0))
      self.layer.borderColor = borderColor.cgColor
      self.layer.borderWidth = borderWidth
      self.layer.backgroundColor = backgroundColor.cgColor
      self.clipsToBounds = true
   }
}
