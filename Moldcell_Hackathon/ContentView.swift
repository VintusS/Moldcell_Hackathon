//
//  ContentView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 15.03.2024.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Schedule Notification") {
                scheduleNotification()
            }
        }
    }

    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        
        // Request permission to display alerts and play sounds.
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on the authorization.
            if granted {
                // Create the notification content
                let content = UNMutableNotificationContent()
                content.title = "Privet"
                content.body = "Paca"
                content.sound = UNNotificationSound.default

                // Create the trigger as a repeating event.
                let date = Date().addingTimeInterval(5) // 5 seconds from now
                let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

                // Create the request
                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

                // Schedule the request with the system.
                center.add(request) { (error) in
                    if let error = error {
                        // Handle any errors.
                        print("Error scheduling notification: \(error)")
                    }
                }
            } else if let error = error {
                print("Error requesting authorization: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
