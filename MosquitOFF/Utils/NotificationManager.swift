//
//  NotificationManager.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 10/05/2025.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager() // Singleton

    private init() {} // Evita instanciar fuera de shared

    // Solicita permiso para notificaciones
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
                if granted {
                    print("✅ Notification permission granted")
                } else {
                    print("❌ Notification permission denied")
                }
            }
        }
    }

    // Envía notificación de alto riesgo de dengue (default 10 seg después)
    func sendDengueRiskNotification(after seconds: TimeInterval = 10) {
        let content = UNMutableNotificationContent()
        content.title = "⚠️ High Dengue Risk"
        content.body = "Weather conditions favor mosquito activity. Take precautions!"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: "dengueRiskAlert", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error sending dengue notification: \(error.localizedDescription)")
            } else {
                print("📢 Dengue risk notification scheduled")
            }
        }
    }

    // Programa recordatorio diario para reportar mosquitos a la hora especificada (default 18 hs)
    func scheduleDailyReminder(hour: Int = 18) {
        let content = UNMutableNotificationContent()
        content.title = "🦟 Daily Reminder"
        content.body = "Have you seen any mosquitoes today? Report them!"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "dailyReportReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling daily reminder: \(error.localizedDescription)")
            } else {
                print("🕕 Daily mosquito report reminder scheduled")
            }
        }
    }
    
    func sendTestDailyReminder(after seconds: TimeInterval = 10) {
        let content = UNMutableNotificationContent()
        content.title = "🦟 Test Daily Reminder"
        content.body = "This is a test daily reminder notification."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)

        let request = UNNotificationRequest(identifier: "testDailyReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error sending test daily reminder: \(error.localizedDescription)")
            } else {
                print("📢 Test daily reminder notification scheduled")
            }
        }
    }


    // Elimina todas las notificaciones pendientes y entregadas
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        print("🔕 All notifications removed")
    }
}



