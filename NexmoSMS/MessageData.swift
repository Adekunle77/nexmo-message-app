//
//  MessageData.swift
//  NexmoSMS
//
//  Created by Ade Adegoke on 08/09/2017.
//  Copyright © 2017 AKA. All rights reserved.
//

import Foundation

struct MessageData {
    
    let messagePrice: String
    let currentBalance: String
    
    init?(json: [String:Any]) {
        if let messagePrice = json["message-price"] as? String {
        self.messagePrice = messagePrice
        } else {
            return nil
        }
        if let currentBalance = json["remaining-balance"] as? String {
            self.currentBalance = currentBalance
        } else {
            return nil
        }
    }
    
}
