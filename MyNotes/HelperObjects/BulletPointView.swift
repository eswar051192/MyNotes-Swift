//
//  BulletPointView.swift
//  MyNotes
//
//  Created by Eswar venigalla on 13/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit
@IBDesignable
class BulletPointView: UIView {

   @IBInspectable
   var color: UIColor = UIColor.white { didSet {setNeedsDisplay()}}
   var borderColorf: UIColor = UIColor.white { didSet {setNeedsDisplay()}}
   var borderWidthf: CGFloat = CGFloat(2.0) { didSet {setNeedsDisplay()}}
   
   @IBInspectable
   var addShadow : Bool = false {
      didSet {
         setNeedsDisplay()
      }
   }
   @IBInspectable
   var shadowShade : UIColor = UIColor.black
   {
      didSet {
         setNeedsDisplay()
      }
   }
   
   private var startPoint: CGPoint {
      return CGPoint(x: bounds.minX, y: bounds.minY)
   }
   
   private var bubbleSize: CGSize {
      return CGSize(width: bounds.width, height: bounds.height)
   }
   
   func getRectPath(forCorner corner: UIRectCorner) -> UIBezierPath
   {
      let rect = CGRect(origin: startPoint , size: bubbleSize)
      let cornerRadius = getCornerRadius(ofCorner: corner)
      return UIBezierPath(roundedRect: rect,
                          byRoundingCorners: [corner],
                          cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
   }
   
   func getCornerRadius(ofCorner corner: UIRectCorner) -> CGFloat
   {
      return self.frame.size.height/2.0
   }
   override func layoutSubviews() {
      super.layoutSubviews()
      self.setNeedsDisplay()
      self.clipsToBounds = true
   }
   override func draw(_ rect: CGRect) {
      self.layer.cornerRadius = self.bounds.height / 2.0
      self.layer.borderWidth = self.borderWidthf
      self.layer.borderColor = self.color.cgColor
   }

}
