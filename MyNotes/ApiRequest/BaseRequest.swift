//
//  BaseRequest.swift
//  MyNotes
//
//  Created by Eswar venigalla on 14/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit
import AFNetworking

typealias APISUCCESS = (URLSessionDataTask?, Any?) -> Void
typealias APIFAILURE = (URLSessionDataTask?, Error?) -> Void

class BaseRequest: NSObject {
   
   var delegate : RequestDelegate!
   var requestId : RequestID!
   var requestType : RequestType!
   var isDynamicApiCall : Bool = false
   var parameter : [String : Any]! = [String : Any]()
   var task : URLSessionDataTask!
   var authenticationToken : String = ""
   var baseUrl : String = ProjectConfigManager.shared.baseUrl
   var dynamicCompleteUrl : String = ""
   var apiKey : String!
   
   static func apiKeyString() -> String{
      return "\(Date.init().timeIntervalSince1970)"
   }
   convenience init(requestId : RequestID,
                    requestType : RequestType,
                    isDynamicApiCall : Bool = false,
                    dynamicCompleteUrl : String = "",
                    params : [String : Any] = [String : Any](),
                    apiKey : String = BaseRequest.apiKeyString()) {
      self.init()
      self.requestId = requestId
      self.requestType = requestType
      self.isDynamicApiCall = isDynamicApiCall
      self.dynamicCompleteUrl = dynamicCompleteUrl
      self.parameter = params
      self.apiKey = apiKey
   }
   
   var finalApiCompleteUrlString : String = ""
   //MARK:-
   func apiComponent() -> String{
      return ""
   }
   //MARK:-
   func hitTheApiCall(){
      if self.isDynamicApiCall{
         self.dynamicApiCall()
      }else{
         self.generalApiCall()
      }
   }
   func dynamicApiCall(){
      let endComponent = self.apiComponent()
      guard let url = URL.init(string: self.dynamicCompleteUrl)else{return}
      let afManager : AFHTTPSessionManager = AFHTTPSessionManager.init(baseURL: url)
      afManager.requestSerializer = AFJSONRequestSerializer.init()
      afManager.responseSerializer = AFJSONResponseSerializer.init()
      
      /*
       api headers
       */
      afManager.requestSerializer.setValue("1.0", forHTTPHeaderField: "application-version")
      let blockSelf = self
      let success : APISUCCESS = {
         (task : URLSessionDataTask?,responseObject : Any?) -> Void in
         if let response = responseObject as? NSDictionary
         {
            if let success = response.value(forKey: "success") as? NSNumber,success.boolValue != true
            {
               let error = ResponseErrorInfo.init(dictionary: response)
               blockSelf.delegate.onFailure(requestId: self.requestId,
                                            error: error,
                                            requestKey: self.apiKey)
               return
            }
         }
         blockSelf.delegate.onSuccess(requestId: self.requestId, response: responseObject, requestKey: self.apiKey)
      }
      let failure : APIFAILURE = {
         (task : URLSessionDataTask?,errorLocal : Error?) -> Void in
         if let error = errorLocal{
            blockSelf.delegate.onFailure(requestId: self.requestId,
                                         error: ResponseErrorInfo.init(error: error),
                                         requestKey: self.apiKey)
         }
      }
      switch self.requestType {
      case .get:
         self.task = afManager.get(endComponent, parameters: self.parameter, success: success, failure: failure)
         break
      case .post:
         self.task = afManager.post(endComponent, parameters: self.parameter, success: success, failure: failure)
         break
      case .put:
         self.task = afManager.put(endComponent, parameters: self.parameter, success: success, failure: failure)
         break
      case .delete:
         self.task = afManager.delete(endComponent, parameters: self.parameter, success: success, failure: failure)
         break
      default:
         break
      }
   }
   func generalApiCall(){
      let endComponent = self.apiComponent()
      guard let url = URL.init(string: self.baseUrl)else{return}
      let afManager : AFHTTPSessionManager = AFHTTPSessionManager.init(baseURL: url)
      afManager.requestSerializer = AFJSONRequestSerializer.init()
      afManager.responseSerializer = AFJSONResponseSerializer.init()
      
      /*
       api headers
       */
      afManager.requestSerializer.setValue("1.0", forHTTPHeaderField: "application-version")
      let blockSelf = self
      let success : APISUCCESS = {
         (task : URLSessionDataTask?,responseObject : Any?) -> Void in
         if let response = responseObject as? NSDictionary
         {
            if let success = response.value(forKey: "success") as? NSNumber,success.boolValue != true
            {
               let error = ResponseErrorInfo.init(dictionary: response)
               blockSelf.delegate.onFailure(requestId: self.requestId,
                                            error: error,
                                            requestKey: self.apiKey)
               return
            }
         }
         blockSelf.delegate.onSuccess(requestId: self.requestId, response: responseObject, requestKey: self.apiKey)
      }
      let failure : APIFAILURE = {
         (task : URLSessionDataTask?,errorLocal : Error?) -> Void in
         if let error = errorLocal{
               blockSelf.delegate.onFailure(requestId: self.requestId,
                                            error: ResponseErrorInfo.init(error: error),
                                            requestKey: self.apiKey)
         }
      }
      switch self.requestType {
      case .get:
         self.task = afManager.get(endComponent, parameters: self.parameter, success: success, failure: failure)
         break
      case .post:
         self.task = afManager.post(endComponent, parameters: self.parameter, success: success, failure: failure)
         break
      case .put:
         self.task = afManager.put(endComponent, parameters: self.parameter, success: success, failure: failure)
         break
      case .delete:
         self.task = afManager.delete(endComponent, parameters: self.parameter, success: success, failure: failure)
         break
      default:
         break
      }
   }
   func cancelTheRequest(){
      self.task.cancel()
   }
   
   func parsedObject(data : Any!) -> Any!{
      return data
   }
}
