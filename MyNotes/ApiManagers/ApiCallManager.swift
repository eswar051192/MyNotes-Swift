//
//  ApiCallManager.swift
//  MyNotes
//
//  Created by Eswar venigalla on 14/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit
class RequestContainer : NSObject{
   override init(){
      super.init()
   }
   var request : BaseRequest?
   var delegate : ResponseDelegate!
   
   convenience init(request : BaseRequest!,
                    delegate : ResponseDelegate!)
   {
      self.init()
      self.request = request
      self.delegate = delegate
   }
}
class ApiCallManager: NSObject {
   var request : [String : RequestContainer] = [String : RequestContainer]()
   var queue : DispatchQueue?
   func add(_ request : BaseRequest,delegate : ResponseDelegate?){
      request.delegate = self
      let container = RequestContainer.init(request: request, delegate: delegate)
      self.request[request.apiKey] = container
      request.hitTheApiCall()
   }
   func getInProgressCall(key : String?) -> RequestContainer?{
      if key == nil{return nil}
      return self.request[key!]
   }
   func removeInProgressCall(key : String?){
      if key == nil{return}
      if let _ = self.request[key!]{
         self.request.removeValue(forKey: key!)
      }
   }
}
extension ApiCallManager : RequestDelegate{
   func onSuccess(requestId: RequestID, response: Any!, requestKey: String!) {
      guard let container = self.getInProgressCall(key: requestKey) else { return }
      guard let request = container.request else { return }
      if self.queue != nil{
         self.queue?.async {
            let parsedData = request.parsedObject(data: response)
            DispatchQueue.main.async {
               if container.delegate != nil{
                  container.delegate.didRecieve(requestId: requestId, resposeData: parsedData, error: nil, userData: nil)
               }
               self.removeInProgressCall(key: requestKey)
            }
         }
      }
   }
   func onFailure(requestId: RequestID, error: ResponseErrorInfo!, requestKey: String!) {
      guard let container = self.getInProgressCall(key: requestKey) else { return }
      let blockSelf = self
      if let _ = error,error.getMessage() == "cancelled"{
         DispatchQueue.main.async {
            blockSelf.removeInProgressCall(key: requestKey)
         }
      }
      if self.queue != nil{
         self.queue?.async  {
            DispatchQueue.main.async {
               if container.delegate != nil{
                  container.delegate.didRecieve(requestId: requestId, resposeData: nil, error: error, userData: nil)
               }
               self.removeInProgressCall(key: requestKey)
            }
         }
      }
      
   }
}
