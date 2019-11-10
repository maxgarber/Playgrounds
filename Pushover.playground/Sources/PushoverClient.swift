import Foundation

public struct PushoverClientCredentials ***REMOVED***
    public var userKey: String = ""
    public var appToken: String = ""
    
    public init() ***REMOVED******REMOVED***
    
    public init(key: String, token: String) ***REMOVED***
        self.userKey = key
        self.appToken = token
    ***REMOVED***
    
    public func asHttpBodyString() -> String ***REMOVED***
        return "user=\(userKey)&token=\(appToken)".addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
    ***REMOVED***
***REMOVED***

public typealias UnixTimestamp = UInt

public enum PushoverMessagePriority: Int ***REMOVED***
    case lowest     = -2
    case low        = -1
    case normal     =  0
    case high       =  1
    case emergency  =  2
    
    public var defaultValue: PushoverMessagePriority ***REMOVED***
        return .normal
    ***REMOVED***
***REMOVED***

public enum PushoverNotificationSound ***REMOVED***
    case pushover
    case bike
    case bugle
    case cashregister
    case classical
    case cosmic
    case falling
    case gamelan
    case incoming
    case intermission
    case magic
    case mechanical
    case pianobar
    case siren
    case spacealarm
    case tugboat
    case alien
    case climb
    case persistent
    case echo
    case updown
    case none
***REMOVED***

public struct PushoverMessage ***REMOVED***
    public var message: String = ""
    public var title: String?
    public var url: URL?
    public var urlTitle: String?
    public var priority: PushoverMessagePriority?
    public var timestamp: UnixTimestamp?
    public var sound: PushoverNotificationSound?
    
    public func asHttpBodyString() -> String ***REMOVED***
        var httpBody = "message=\(message)"
        if let title = title ***REMOVED*** httpBody += "&title=\(title)" ***REMOVED***
        if let url = url ***REMOVED*** httpBody += "&url=\(url)" ***REMOVED***
        if let urlTitle = urlTitle ***REMOVED*** httpBody += "&urlTitle=\(urlTitle)" ***REMOVED***
        if let priority = priority ***REMOVED*** httpBody += "&priority=\(priority)" ***REMOVED***
        if let timestamp = timestamp ***REMOVED*** httpBody += "&timestamp=\(timestamp)" ***REMOVED***
        if let sound = sound ***REMOVED*** httpBody += "&sound=\(sound)" ***REMOVED***
        return httpBody.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    ***REMOVED***
    
    public init(message msg: String = "",
                title: String? = nil,
                url: URL? = nil,
                urlTitle: String? = nil,
                priority: PushoverMessagePriority? = nil,
                timestamp: UnixTimestamp? = nil,
                sound: PushoverNotificationSound? = nil
    ) ***REMOVED***
        message = msg
        if let title = title ***REMOVED*** self.title = title ***REMOVED***
        if let url = url ***REMOVED*** self.url = url ***REMOVED***
        if let urlTitle = urlTitle ***REMOVED*** self.urlTitle = urlTitle ***REMOVED***
        if let priority = priority ***REMOVED*** self.priority = priority ***REMOVED***
        if let timestamp = timestamp ***REMOVED*** self.timestamp = timestamp ***REMOVED***
        if let sound = sound ***REMOVED*** self.sound = sound ***REMOVED***
    ***REMOVED***
***REMOVED***

public enum APIError: Error ***REMOVED***
    case statusCode(Int)
    case other(Error)
    case unknown
***REMOVED***


public class PushoverClient ***REMOVED***
    public static let baseURL = URL(string:"https://api.pushover.net/1")!
    public static let sendMessageURL = baseURL.appendingPathComponent("/messages.json", isDirectory: false)
    
    public var credentials: PushoverClientCredentials
    
    public init(withCredentials creds: PushoverClientCredentials) ***REMOVED***
        credentials = creds
    ***REMOVED***
    
    public func send(message: PushoverMessage, onSuccess: @escaping (Data)->Void, onError: @escaping (Error)->Void) ***REMOVED***
        var sendMessageRequest = URLRequest(url: PushoverClient.sendMessageURL)
        sendMessageRequest.httpMethod = "POST"
        sendMessageRequest.httpBody = (
            credentials.asHttpBodyString() + "&" +
            message.asHttpBodyString()
        ).data(using: .utf8)
        
        let sendMessageTask = URLSession.shared.dataTask(with: sendMessageRequest) ***REMOVED*** data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else ***REMOVED***
                return onError(error ?? APIError.unknown)
            ***REMOVED***
            guard (200 ... 299) ~= response.statusCode else ***REMOVED***
                return onError(APIError.statusCode(response.statusCode))
            ***REMOVED***
            onSuccess(data)
        ***REMOVED***
        sendMessageTask.resume()
    ***REMOVED***
    
***REMOVED***
