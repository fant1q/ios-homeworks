//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.05.2023.
//

import Foundation
import UIKit
import UserNotifications

final class LocalNotificationsService: NSObject {
    
    func registeForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .badge, .provisional]) { granted, error in
            if granted {
                print("Доступ разрешен")
            } else {
                print("Доступ не получен")
            }
        }
    }
    
    func scheduleNotification() {
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Посмотрите последние обновления"
        content.body = "Пока вас не было произошло много интересного"
        content.sound = .default
        content.categoryIdentifier = "updates"
        DispatchQueue.main.async {
            content.badge = ((UIApplication.shared.applicationIconBadgeNumber + 1)) as NSNumber
        }
        
        var dateComponenets = DateComponents()
        dateComponenets.hour = 19
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponenets, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
    
    func registerUpdatesCategory() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let positiveAction = UNNotificationAction(identifier: "show more", title: "Показать больше", options: .foreground)
        let negativeAction = UNNotificationAction(identifier: "cancel", title: "Закрыть", options: .destructive)
        
        let category = UNNotificationCategory(identifier: "updates", actions: [positiveAction, negativeAction], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
}

extension LocalNotificationsService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber -= 1
        
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("Default Identifier")
        case "show more":
            print("show more")
        case "cancel":
            print("cancel")
        default:
            break
        }
        completionHandler()
    }
}
