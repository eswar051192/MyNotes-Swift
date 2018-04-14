//
//  CoreDataManager.swift
//  MyNotes
//
//  Created by Eswar venigalla on 12/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit
import CoreData
class CoreDataManager: NSObject {
   static var shared : CoreDataManager {
      let instance = CoreDataManager()
      return instance
   }
   lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "MyNotes")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
         if let error = error as NSError? {
            print("Unresolved error \(error), \(error.userInfo)")
         }
      })
      return container
   }()
   
   // MARK: - Core Data Saving support
   
   func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
         do {
            try context.save()
         } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
         }
      }
   }
   static var getPrivateContext : NSManagedObjectContext{
      get{
         let context = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
         context.parent = CoreDataManager.shared.persistentContainer.viewContext
         return context
      }
     
   }
   static var getMainContext : NSManagedObjectContext{
      get{
         return CoreDataManager.shared.persistentContainer.viewContext
      }
   }
   func saveContext(context : NSManagedObjectContext,completion : CompletionHandler?){
      do {
         try context.save()
         if let parent = context.parent{
            self.saveContext(context: parent, completion: { (success) in
               completion?(success)
            })
         }else{
            completion?(true)
         }
      } catch {
         print("\(error.localizedDescription)")
         completion?(false)
      }
   }
   
   
   func newCoreDataObject(entity : String, context : NSManagedObjectContext) -> NSManagedObject{
      return NSEntityDescription.insertNewObject(forEntityName: entity, into: context)
   }

}
