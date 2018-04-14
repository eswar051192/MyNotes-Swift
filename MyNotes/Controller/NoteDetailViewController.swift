//
//  NoteDetailViewController.swift
//  MyNotes
//
//  Created by Eswar venigalla on 14/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit

class NoteDetailViewController: BaseController {
   
   @IBOutlet var tableView : UITableView!
   var note : Notes?
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   override func loadNavigationControllerInNormalMode() {
      super.loadNavigationControllerInNormalMode()
      if self.note == nil{
         self.navigationController?.popViewController(animated: true)
         return
      }
   }
}
extension NoteDetailViewController : UITableViewDataSource{
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 6
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      return cell
   }
}
