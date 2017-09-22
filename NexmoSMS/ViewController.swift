//
//  ViewController.swift
//  NexmoSMS
//
//  Created by Ade Adegoke on 29/08/2017.
//  Copyright © 2017 AKA. All rights reserved.
//

import UIKit




class ViewController: UIViewController {

        //Outlets
        @IBOutlet weak var balanceOutlet: UILabel!
        @IBOutlet weak var costPrice: UILabel!
        @IBOutlet weak private var enterNumberOutlet: UITextField!
        @IBOutlet weak private var messageFromOutlet: UITextField!
        @IBOutlet weak private var theMessageOutlet: UITextView!
        
        
        private var messageFrom: String?
        private var messageTo: String?
        private var theMessage: String?
        private var messageCost: String?

    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
          }

    
        private func createAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)  
        }))

        self.present(alert, animated: true, completion: nil)
        }


        // Action for the user to send the message
        @IBAction private func sendMessage(_ sender: Any) {

        guard let enteredNumberText = enterNumberOutlet.text else {return}

        if enteredNumberText == "" {

        createAlert(title: "Sorry!", message: "Please enter a phone number")

        } else {

        self.messageTo = enteredNumberText
        let notAllowedNumber = enteredNumberText.characters.index((enteredNumberText.characters.startIndex), offsetBy: 2)
        print(notAllowedNumber)

        if enteredNumberText[notAllowedNumber] == "0" {

        createAlert(title: "Sorry!", message: "Please delete the number 0 at the beginning of your number")


        print(self.messageTo!)
            }


        }
        
        guard let newMessageFromOutlet = messageFromOutlet.text else {return}

        if newMessageFromOutlet == "" {

        createAlert(title: "Sorry!", message: "Please enter who is sending the message")

        } else {
        
        
        let newMessage = newMessageFromOutlet.replacingOccurrences(of: " ", with: "+")

        self.messageFrom = newMessage
        print(self.messageFrom!)
        }

        guard let theNewMessages = theMessageOutlet.text else {
        return
        }

        if theNewMessages == "" {
        createAlert(title: "Sorry!", message: "Please enter a message")

        } else {

        let theNewUpdatedMessage = theNewMessages.replacingOccurrences(of: " ", with: "+")

        self.theMessage = theNewUpdatedMessage
        print(self.theMessage!)

        SMSModel.shared.sendSMSMessage(self.messageFrom!, to: self.messageTo!, messageSent: self.theMessage!) {[weak self] profiles, error in
        DispatchQueue.main.async {
        for messages in profiles! {

        self?.costPrice.text = "£\(messages.messagePrice)"
        self?.balanceOutlet.text = "£\(messages.currentBalance)"


                        }
                    }
                }

            }

        }

}
