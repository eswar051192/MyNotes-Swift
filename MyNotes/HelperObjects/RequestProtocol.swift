//
//  RequestProtocol.swift
//  MyNotes
//
//  Created by Eswar venigalla on 14/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import Foundation
protocol ResponseDelegate {
   func didRecieve(requestId:RequestID,resposeData:Any?,error:ResponseErrorInfo?,userData:[String : Any]?)
}
protocol RequestDelegate {
   func onSuccess(requestId : RequestID,response : Any!,requestKey : String!)
   func onFailure(requestId : RequestID,error : ResponseErrorInfo!,requestKey : String!)
}
enum RequestID : Int64 {
   case login = 1
   case logout = 2
   case uploadNotes = 3
}
enum RequestType : String{
   case get = "GET"
   case post = "POST"
   case put = "PUT"
   case delete = "DELETE"
}

class ResponseErrorInfo : NSObject{
   private var errorMessage : String = ""
   private var errorCode : Int64 = 0
   private var errorDetails : String = ""
   private var errorId : String = ""
   convenience init(dictionary : NSDictionary) {
      self.init()
      
      if let obj = dictionary.value(forKey: "id") as? String{
         self.errorId = obj
      }else if let obj = dictionary.value(forKey: "id") as? NSNumber{
         self.errorId = "\(obj)"
      }
      if let obj = dictionary.value(forKey: "message") as? String{
         self.errorMessage = obj
      }
      if let obj = dictionary.value(forKey: "message") as? String{
         self.errorDetails = obj
      }
      if let obj = dictionary.value(forKey: "errorcode") as? NSNumber{
         self.errorCode = obj.int64Value
      }
   }
   convenience init (error : Error!){
      
      self.init()
      if error == nil{
         return
      }
      self.errorCode = Int64((error as NSError).code)
      self.errorDetails = error.localizedDescription
      self.errorMessage = error.localizedDescription
      self.errorId = "HTTP"
   }
   func getCode() -> Int64{
      return self.errorCode
   }
   func getMessage() -> String{
      return self.errorMessage
   }
   func getDetails() -> String{
      return self.errorDetails
   }
}

