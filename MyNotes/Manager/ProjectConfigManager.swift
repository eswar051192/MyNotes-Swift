//
//  ProjectConfigManager.swift
//  MyNotes
//
//  Created by Eswar venigalla on 14/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit

class ProjectConfigManager: NSObject {
   static var shared : ProjectConfigManager = ProjectConfigManager.init()
   var _apiCallConfigDict : NSMutableDictionary!
   var apiCallConfigDict : NSMutableDictionary{
      get{
         if self._apiCallConfigDict == nil{
            let path = Bundle.main.bundlePath
            let finalPath = (path as NSString).appendingPathComponent("ApiCall.plist")
            self._apiCallConfigDict = NSMutableDictionary.init(contentsOfFile: finalPath)
         }
         return self._apiCallConfigDict
      }
   }
   var _baseUrl : String = ""
   var baseUrl : String{
      get{
         if self._baseUrl == ""{
            if let url = self.apiCallConfigDict.value(forKey: "BASE_URL") as? String{
               self._baseUrl = url
            }
         }
         return self._baseUrl
      }
   }
}
