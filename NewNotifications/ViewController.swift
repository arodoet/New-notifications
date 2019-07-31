//
//  ViewController.swift
//  NewNotifications
//
//  Created by Teodora Knezevic on 7/11/19.
//  Copyright © 2019 Teodora Knezevic. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Trazimo dozvolu
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.badge,.sound], completionHandler: {(granted, error) in
            
            if granted{
                print("Notification access granted")
            }else{
                print(error?.localizedDescription)
            }
            
        })
    }
    
    func scheduleNotifications(inSeconds:TimeInterval, completion:@escaping (_ success:Bool)->()){
        
        let myImage = "rick_grimes"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif")
            else {
                completion(false)
                return
        }
        
        var attachement:UNNotificationAttachment
        attachement = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        
        let notif = UNMutableNotificationContent()
        notif.title = "New notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are superr greatt!!!"
        notif.attachments = [attachement]
        
        //OVO je SAMO ZA CONTENT EXTENSION
        notif.categoryIdentifier = "myNotificationCategory"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil{
                print(error)
                completion(false)
            }else{
                completion(true)
            }
        }
    }


    @IBAction func notifyButtonPressed(_ sender: Any) {
        
        scheduleNotifications(inSeconds: 5) { (success) in
            if success{
                print("Successfully scheduled notification")
            }else{
                print("Error scheduling notification")
            }
        }
    }
}

