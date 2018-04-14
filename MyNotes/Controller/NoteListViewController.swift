//
//  NoteListViewController.swift
//  MyNotes
//
//  Created by Eswar venigalla on 12/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit

class NoteListViewController: BaseController {
   
   @IBOutlet var tableView : UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
   }
   
   override func loadNavigationControllerInNormalMode(){
      super.loadNavigationControllerInNormalMode()
      
      
      self.tableView.isHidden = NotesListManager.shared.getRowCount(section: 0) == 0
      if !self.tableView.isEditing{
         let addButton = UIBarButtonItem.init(title: "Add", style: .done, target: self, action: #selector(NoteListViewController.addNewEntry))
         addButton.tintColor = UIColor.white
         self.navigationItem.rightBarButtonItem = addButton
         if !self.tableView.isHidden{
            let editModeButton = UIBarButtonItem.init(title: "Edit", style: .done, target: self, action: #selector(NoteListViewController.activateEditMode))
            editModeButton.tintColor = UIColor.white
            self.navigationItem.leftBarButtonItem = editModeButton
         }
         
      }else if !self.tableView.isHidden{
         self.navigationItem.rightBarButtonItems = []
         let editModeButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(NoteListViewController.activateEditMode))
         editModeButton.tintColor = UIColor.white
         self.navigationItem.leftBarButtonItems = [editModeButton]
      }
      self.navigationItem.title = "Notes"
      self.tableView.reloadData()
   }
   @objc func addNewEntry(){
      if let addNewVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewNoteViewController") as? AddNewNoteViewController{
         self.navigationController?.pushViewController(addNewVC, animated: true)
      }
   }
   @objc func activateEditMode(){
      self.tableView.isEditing = !self.tableView.isEditing
      self.loadNavigationControllerInNormalMode()
   }
}
extension NoteListViewController : UITableViewDataSource,UITableViewDelegate{
   func numberOfSections(in tableView: UITableView) -> Int {
      return NotesListManager.shared.getSectionCount()
   }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return NotesListManager.shared.getRowCount(section: section)
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteListCell
      if let note = NotesListManager.shared.getNotes(indexPath) {
         cell.nameOfCell.text = note.note_name
      }
      
      cell.countView.isHidden = true
      return cell
   }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if let note = NotesListManager.shared.getNotes(indexPath) {
         NotesListManager.shared.notes = note
         self.addNewEntry()
      }
   }
   func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
      return .delete
   }
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      if let note = NotesListManager.shared.getNotes(indexPath) {
         NotesListManager.shared.notes = note
         NotesListManager.shared.updateValue(title: note.note_name ?? "", notes: note.note_text ?? "", isDelete: true, completion: { (success) in
            DispatchQueue.main.async {
               self.activateEditMode()
            }
         })
      }
   }
   func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
      if indexPath != nil{
         
      }
   }
}

