//
//  NoteListCell.swift
//  MyNotes
//
//  Created by Eswar venigalla on 12/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit

class NoteListCell: UITableViewCell {
   
   @IBOutlet var nameOfCell : UILabel!
   
   @IBOutlet var lineView : UIView!
   
   @IBOutlet var countView : UIView!
   @IBOutlet var countLabel : UILabel!
   @IBOutlet var countWidthConstraint : NSLayoutConstraint!
   
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
   
}

