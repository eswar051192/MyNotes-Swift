//
//  LoginApiCall.swift
//  MyNotes
//
//  Created by Eswar venigalla on 15/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit

class LoginApiCall: BaseRequest {
   override func apiComponent() -> String {
      //EndCompontest of api
      return "/sampleApiCall"
   }
   override func parsedObject(data: Any!) -> Any! {
      //Here we parse Response
      return data
   }
}
