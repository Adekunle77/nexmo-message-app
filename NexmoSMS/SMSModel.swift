//
//  SMSModel.swift
//  NexmoSMS
//
//  Created by Ade Adegoke on 29/08/2017.
//  Copyright © 2017 AKA. All rights reserved.
//

import Foundation



class SMSModel {

    static let shared = SMSModel()

    
    // Enter API KEY
    private let apiKey = "930c1ebb"
    // Enter Secret Key
    private let secretKey = "59bf0bad6077e9f1"
    
    func sendSMSMessage(_ from: String, to: String, messageSent: String, completion: @escaping (([MessageData]?, Error?) -> Void)) {
   
    var messageInfo: [MessageData] = []

    // Url link with api key and secret key
    let url = "https://rest.nexmo.com/sms/json?api_key=" + apiKey + "&api_secret=" + secretKey + "&from=" + from + "&to=" + to + "&text=" + messageSent

    let request = URLRequest(url: URL(string: url)!)

     //   making the rest api call
        let task = URLSession.shared.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
 
                if let data = data {

                do {

                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                if let messageJSON = json["messages"] as? [[String:Any]] {

                for singleMessageJSON in messageJSON {
                    
                if let messageData = MessageData(json: singleMessageJSON){
                messageInfo.append(messageData)
                                        }

                                    }
                                }
                                completion(messageInfo, nil)
                            }

                        }catch {

                    print(error.localizedDescription)
                    }

                }

            }

        task.resume()
    
    }
    
}
