//
//  CornerView.swift
//  MyNotes
//
//  Created by Eswar venigalla on 13/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit
@IBDesignable class CornerView: UIView {

   @IBInspectable
   var color: UIColor = UIColor.blue { didSet {setNeedsDisplay()}}
   
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
   @IBInspectable
   var topLeftCornerRadius : CGFloat = 0.0 {
      didSet {
         setNeedsDisplay()
      }
   }
   
   @IBInspectable
   var bottomLeftCornerRadius : CGFloat = 2.0 {
      didSet {
         setNeedsDisplay()
      }
   }
   
   @IBInspectable
   var bottomRightCornerRadius : CGFloat = 2.0 {
      didSet {
         setNeedsDisplay()
      }
   }
   
   @IBInspectable
   var topRightCornerRadius : CGFloat = 2.0 {
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
      switch corner {
      case UIRectCorner.topLeft:
         return topLeftCornerRadius
      case UIRectCorner.topRight:
         return topRightCornerRadius
      case UIRectCorner.bottomLeft:
         return bottomLeftCornerRadius
      case UIRectCorner.bottomRight:
         return bottomRightCornerRadius
      default:
         return 0.0
      }
   }
   override func layoutSubviews() {
      super.layoutSubviews()
      self.setNeedsDisplay()
      self.clipsToBounds = true
   }
   override func draw(_ rect: CGRect) {
      let topLeftPath = getRectPath(forCorner: .topLeft)
      let topRighPath = getRectPath(forCorner: .topRight)
      let bottomLeftPath = getRectPath(forCorner: .bottomLeft)
      let bottomRightPath = getRectPath(forCorner: .bottomRight)
      
      color.setFill()
      topLeftPath.addClip()
      topRighPath.addClip()
      bottomLeftPath.addClip()
      bottomRightPath.addClip()
      
      topRighPath.fill()
      topLeftPath.fill()
      bottomRightPath.fill()
      bottomLeftPath.fill()
      
   }

}
