//
//  SettingsView.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 10/05/2025.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @State private var isNotificationEnabled: Bool = false
    private let notificationManager = NotificationManager.shared

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notification Settings")) {
                    Toggle(isOn: $isNotificationEnabled) {
                        Text("Enable Daily Notifications")
                    }
                    .onChange(of: isNotificationEnabled) { value in
                        // When toggle value changes, enable or disable notifications
                        if value {
                            notificationManager.scheduleDailyReminder()
                            notificationManager.sendDengueRiskNotification()
                        } else {
                            notificationManager.removeAllNotifications()
                        }
                    }
                    
                    // Inform user if notifications are allowed
                    if !isNotificationEnabled {
                        Text("Please enable notifications in settings")
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .onAppear {
                // Check if notifications are enabled
                checkNotificationPermission()
            }
        }
    }

    private func checkNotificationPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                isNotificationEnabled = settings.authorizationStatus == .authorized
            }
        }
    }
}

#Preview {
    SettingsView()
}
