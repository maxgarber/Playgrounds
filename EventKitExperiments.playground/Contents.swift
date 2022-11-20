import Foundation
import EventKit
import PlaygroundSupport


func ensureAccess(_ eventStore: EKEventStore) async throws {
    let authorization = EKEventStore.authorizationStatus(for: .reminder)
    if authorization != .authorized {
        let isAccessAllowed = try await eventStore.requestAccess(to: .reminder)
        guard isAccessAllowed else {
            throw NSError(domain: "me.maxgarber.EventKitExperiments", code: -1)
        }
    } else {
        
    }
}

func enumerateReminderLists(_ eventStore: EKEventStore) -> [EKCalendar] {
    let remindersLists = eventStore.calendars(for: .reminder)
    guard remindersLists.isEmpty == false else {
        print("Error: List of reminders lists was empty")
        exit(0)
    }
    return remindersLists
}


func pseudoMain(reminderListName: String = "Inbox") {
    Task {
        let eventStore = EKEventStore()
        do {
            try await ensureAccess(eventStore)
            let remindersLists = enumerateReminderLists(eventStore)
            
            let predicate = eventStore.predicateForIncompleteReminders(withDueDateStarting: nil, ending: nil, calendars: remindersLists)
            let reminderItems = try await eventStore.reminders(matching: predicate)
            
            print("> Retrieved \(reminderItems.count) reminders from \(remindersLists.count) lists, of which:")
            
            let remindersWithNotes = reminderItems.filter({ $0.hasNotes })
            print("  \(remindersWithNotes.count) have notes")
            
            let remindersWithURLs = reminderItems.filter({ $0.url != nil })
            print("  \(remindersWithURLs.count) have URLs")
            
            let remindersWithLocations = reminderItems.filter({ $0.location != nil })
            print("  \(remindersWithLocations.count) have locations")
            

            if let privateRemindersList = remindersLists.first(where: { calendar in
                calendar.title.contains(reminderListName)
            }) {
                let predicate = eventStore.predicateForIncompleteReminders(withDueDateStarting: nil, ending: nil, calendars: [privateRemindersList])
                let privateReminderItems = try await eventStore.reminders(matching: predicate)
                print("> Private reminders list found with \(privateReminderItems.count) items")
                
                if let firstItem = privateReminderItems.first {
                    let firstItemTitle = firstItem.title ?? "<no title>"
                    print("  - first item is: \"\(firstItemTitle)\"")
                    print("    has attribute keys: \(firstItem.attributeKeys)")
                }
                
                // let itemsWithURLs = privateReminderItems.filter { reminder in
                //     reminder.url != nil
                // }
                // print("> Found \(itemsWithURLs.count) items in the private list with URLs")
                
            }
            
        } catch {
            print("Error thrown: \(error)")
            exit(1)
        }
        
    }
}

pseudoMain()

