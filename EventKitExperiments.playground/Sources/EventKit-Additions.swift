import Foundation
import EventKit


public extension EKEventStore {
    
    /// Async wrapper of `fetchReminders(matching: NSPredicate, completion: ([EKReminder]?) -> Void)`
    func reminders(matching predicate: NSPredicate) async throws -> [EKReminder] {
        return try await withCheckedThrowingContinuation { continuation in
            self.fetchReminders(matching: predicate) { reminders in
                if let reminders {
                    continuation.resume(returning: reminders)
                } else {
                    continuation.resume(throwing: NSError(domain: "EventKit.fetchReminders(matching:completion:).completionReceivedNilArgument", code: -1))
                }
            }
        }
    }
    
}
