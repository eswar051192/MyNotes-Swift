//
//  LoginApiCallManager.swift
//  MyNotes
//
//  Created by Eswar venigalla on 15/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit

class LoginApiCallManager: ApiCallManager {
   static var shared : LoginApiCallManager = LoginApiCallManager.init()
   override init() {
      super.init()
      self.queue = DispatchQueue(label: "com.mynotes.loginApiCallManager")
   }
   func  saveNotesToServer(note : Notes, responseDelegate : ResponseDelegate?){
      var param = [String : Any]()
      param["Note"] = note.note_text ?? ""
      param["NoteTitle"] = note.note_name ?? ""
      param["NoteData"] = "\(String(describing: note.note_date?.timeIntervalSince1970))"
      param["NoteOrder"] = note.note_order
      let request = NoteUploadRequest.init(requestId : RequestID.uploadNotes,
                                           requestType : RequestType.post,
                                           isDynamicApiCall : false,
                                           params : param) as BaseRequest
      self.add(request, delegate: responseDelegate)
   }
}
