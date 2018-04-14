//
//  NotesListManager.swift
//  MyNotes
//
//  Created by Eswar venigalla on 13/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit
import CoreData
typealias CompletionHandler = (_ success:Bool) -> Void
class NotesListManager: NSObject {
   static var shared : NotesListManager = NotesListManager()
   override init() {
      
   }
   var notes : Notes?
   private var listOfNotes : [Notes] {
      get{
         let fetch = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Notes")
         fetch.predicate = NSPredicate.init(format: "note_delete != true")
         fetch.sortDescriptors = [NSSortDescriptor.init(key: "note_order", ascending: true),NSSortDescriptor.init(key: "note_date", ascending: true)]
         var results = [Notes]()
         do {
            if let fetched = try CoreDataManager.getMainContext.fetch(fetch) as? [Notes]{
               results = fetched
            }
            
         } catch {
            print("\(error.localizedDescription)")
         }
         return results
      }
   }
   public func getSectionCount() -> NSInteger{
      return 1
   }
   public func getRowCount(section : NSInteger) -> NSInteger{
      return self.listOfNotes.count
   }
   public func getNotes(_ indexPath : IndexPath) -> Notes?{
      if indexPath.row < self.listOfNotes.count{
         return self.listOfNotes[indexPath.row]
      }
      return nil
      
   }

   public func updateValue(title : String, notes : String, isDelete : Bool = false, completion : CompletionHandler?){
      let context = CoreDataManager.getPrivateContext
      guard let objectId = self.notes?.objectID else {
         completion!(false)
         return
      }
      if let newObject = context.object(with: objectId) as? Notes{
         newObject.note_name = title
         newObject.note_text = notes
         newObject.note_delete = isDelete
         newObject.note_order = Int64(self.listOfNotes.count)
         CoreDataManager.shared.saveContext(context: context, completion : { (success) in
            completion?(success)
            LoginApiCallManager.shared.saveNotesToServer(note: newObject, responseDelegate: self)
         })
      }
      self.notes = nil
   }
   public func saveValue(title : String, notes : String, completion : CompletionHandler?){
      let context = CoreDataManager.getPrivateContext
      if let newObject = CoreDataManager.shared.newCoreDataObject(entity : "Notes", context : context) as? Notes{
         newObject.note_date = Date.init()
         newObject.note_name = title
         newObject.note_text = notes
         newObject.note_delete = false
         newObject.note_order = Int64(self.listOfNotes.count)
         CoreDataManager.shared.saveContext(context: context, completion : { (success) in
            completion?(success)
            LoginApiCallManager.shared.saveNotesToServer(note: newObject, responseDelegate: self)
         })
      }
   }
   
}
extension NotesListManager : ResponseDelegate{
   func didRecieve(requestId: RequestID,
                   resposeData: Any?,
                   error: ResponseErrorInfo?,
                   userData: [String : Any]?) {
      
   }
}

