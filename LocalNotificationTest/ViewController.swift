//
//  ViewController.swift
//  LocalNotificationTest
//
//  Created by 2B on 28/01/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DatePicker: UIDatePicker!
    
    @IBOutlet private weak var testNotificationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    private func scheduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Schedule Notification"
        content.subtitle = "Schedule Notification SubTitle"
        content.body = "Schedule Notification SubTitle Schedule Notification SubTitle Schedule Notification SubTitle"
        content.sound = .default
        content.badge = 0
        content.userInfo = ["name" : "Ahmed Abo Elsood"]
        
        //MARK: - second time Interval
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(3), repeats: false)
        
        //MARK: - Specific time
        
//        var componant = DateComponents()
//        componant.day = 1 // sunday
//        componant.hour = 22
//        componant.minute = 30
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: componant, repeats: true)
        
        //MARK: - Using Date Picker
        
        let date = DatePicker.date
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date), repeats: false)
        
        let request = UNNotificationRequest(identifier: "ID", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    private func removeSchedule(){
        //MARK: - remove All
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        //MARK: - remove spesefic schedule
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["ID"])
    }
    
    @IBAction func testNotificationAction(_ sender: Any) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { success, error in
            switch success{
            case true:
                print("Allowed")
                DispatchQueue.main.async {
                self.scheduleNotification()
                }
            case false:
                print("Denied")
            }
        }
    }
    
}

