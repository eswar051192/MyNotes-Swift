//
//  AddNewNoteViewController.swift
//  MyNotes
//
//  Created by Eswar venigalla on 13/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
class AddNewNoteViewController: BaseController {

   @IBOutlet var notesName : JVFloatLabeledTextView!
   @IBOutlet var notes : JVFloatLabeledTextView!
   @IBOutlet var notesBgView : CornerView!
   
   @IBOutlet var notesSaveStatus : CornerView!
   @IBOutlet var notesSaveStatusLabel : UILabel!
   @IBOutlet var notesSaveStatusActvity : UIActivityIndicatorView!
   @IBOutlet var notesSaveStatusActvityHeight : NSLayoutConstraint!
   
   
   var existingNote : Bool {
      get{
         return NotesListManager.shared.notes != nil
      }
   }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
   func keyBoardOpen(){
      let notesBGView : CornerView = self.notesBgView
      let screen : AddNewNoteViewController = self
      self.view.addKeyboardPanning
         { (keyBoard, open, close) in
            var crect : CGRect = notesBGView.frame
            if (open)
            {
               crect.size.height = (screen.view.frame.size.height - 20.0) - keyBoard.size.height
               notesBGView.frame = crect
            } else if close
            {
               crect.size.height = screen.view.frame.size.height - 20.0
               notesBGView.frame = crect
            }
      }
   }
   @IBAction func tapToEndEditing(){
      self.view.endEditing(true)
      self.view.endEditing(false)
   }
   override func loadNavigationControllerInNormalMode(){
      super.loadNavigationControllerInNormalMode()
      self.keyBoardOpen()
      if existingNote{
         let addButton = UIBarButtonItem.init(title: "Update", style: .done, target: self, action: #selector(self.updateExistingEntry))
         addButton.tintColor = UIColor.white
         self.navigationItem.rightBarButtonItem = addButton
      }else{
         let addButton = UIBarButtonItem.init(title: "Add", style: .done, target: self, action: #selector(self.addNewEntry))
         addButton.tintColor = UIColor.white
         self.navigationItem.rightBarButtonItem = addButton
      }
      if let editModeButton = self.navigationItem.backBarButtonItem{
         editModeButton.tintColor = UIColor.white
         self.navigationItem.hidesBackButton = true
         self.navigationItem.leftBarButtonItem = editModeButton
      }
      if let notes = NotesListManager.shared.notes{
         self.notes.text = notes.note_text != nil ? notes.note_text! : ""
         self.notesName.text = notes.note_name != nil ? notes.note_name! : ""
         self.navigationItem.title = "Edit Note"
      }else{
         self.notes.text = ""
         self.notesName.text = ""
         self.navigationItem.title = "New Note"
      }
      self.navigationController?.navigationBar.tintColor = UIColor.white
      self.activityIndicatorView(showMain: false, showActivity: false)
      
   }
 
   func activityIndicatorView(showMain : Bool,showActivity : Bool,text : String = ""){
      DispatchQueue.main.async {
         self.view.bringSubview(toFront: self.notesSaveStatus)
         self.notesSaveStatus.isHidden = !showMain
         self.notesSaveStatusLabel.text = text
         self.notesSaveStatusActvity.startAnimating()
         self.notesSaveStatusActvity.isHidden = showActivity
         self.notesSaveStatusActvityHeight.constant = showActivity ? 20 : 0
      }
   }
   @objc func addNewEntry(){
      if let notesName = self.notesName.text,
         notesName.count > 0,
         let notes = self.notes.text,
         notes.count > 0{
         self.activityIndicatorView(showMain: true, showActivity: true, text: "Note is being ssaved...")
         NotesListManager.shared.saveValue(title: notesName, notes: notes, completion: { (success) in
            if success{
               DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 3000), execute: {
                  DispatchQueue.main.async {
                     self.navigationController?.popViewController(animated: true)
                  }
               })
               
               self.activityIndicatorView(showMain: true, showActivity: false, text: "Note is saved successfully")
            }else{
               self.activityIndicatorView(showMain: false, showActivity: false, text: "")
               
            }
            
            
         })
      }
      
   }
   @objc func updateExistingEntry(){
      if let notesName = self.notesName.text,
         notesName.count > 0,
         let notes = self.notes.text,
         notes.count > 0{
         self.activityIndicatorView(showMain: true, showActivity: true, text: "Note is updating...")
         NotesListManager.shared.updateValue(title: notesName, notes: notes, isDelete: false, completion: { (success) in
            if success{
               DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 3000), execute: {
                  DispatchQueue.main.async {
                     self.navigationController?.popViewController(animated: true)
                  }
               })
               self.activityIndicatorView(showMain: true, showActivity: false, text: "Note is updated successfully")
            }else{
               self.activityIndicatorView(showMain: false, showActivity: false, text: "")
               
            }
         })
      }
      
   }
   
}
extension AddNewNoteViewController : UITextDragDelegate{
   
}
extension AddNewNoteViewController : UITextViewDelegate{
   func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      if text == "\n" && textView.isEqual(self.notesName) {
         textView.resignFirstResponder()
         self.notes.becomeFirstResponder()
         return false
      }
      if let textInTextView = textView.text{
         let updatedText = text == "" && (textInTextView as NSString).length != 0 ? (textInTextView as NSString).substring(to: (textInTextView as NSString).length - 1) as String : textView.text + text
         if textView == self.notes{
            return (updatedText as NSString).length < 500
         }else if textView == self.notesName{
            return (updatedText as NSString).length < 144
         }
      }
      return true
   }
}
extension AddNewNoteViewController : UITextPasteDelegate{
   
}
extension AddNewNoteViewController : UITextDropDelegate{
   
}
