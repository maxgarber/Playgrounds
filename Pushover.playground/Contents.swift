import Foundation

//
public struct PushoverClientCredentials {
    var userKey: String = ""
    var appToken: String = ""
    
    init() {}
    
    init(key: String, token: String) {
        self.userKey = key
        self.appToken = token
    }
    
    public func asHttpBodyString() -> String {
        return "user=\(userKey)&token=\(appToken)".addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
    }
}


public typealias UnixTimestamp = UInt

public enum PushoverMessagePriority: Int {
    case lowest     = -2
    case low        = -1
    case normal     =  0
    case high       =  1
    case emergency  =  2
    
    public var defaultValue: PushoverMessagePriority {
        return .normal
    }
}

public enum PushoverNotificationSound {
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
}

public struct PushoverMessage {
    public var message: String
    public var title: String?
    public var url: URL?
    public var urlTitle: String?
    public var priority: PushoverMessagePriority?
    public var timestamp: UnixTimestamp?
    public var sound: PushoverNotificationSound?
    
    public func asHttpBodyString() -> String {
        var httpBody = "message=\(message)"
        if let title = title { httpBody += "&title=\(title)" }
        if let url = url { httpBody += "&url=\(url)" }
        if let urlTitle = urlTitle { httpBody += "&urlTitle=\(urlTitle)" }
        if let priority = priority { httpBody += "&priority=\(priority)" }
        if let timestamp = timestamp { httpBody += "&timestamp=\(timestamp)" }
        if let sound = sound { httpBody += "&sound=\(sound)" }
        return httpBody.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum APIError: Error {
    case statusCode(Int)
    case other(Error)
    case unknown
}


public class PushoverClient {
    public static let baseURL = URL(string:"https://api.pushover.net/1")!
    public static let sendMessageURL = baseURL.appendingPathComponent("/messages.json", isDirectory: false)
    
    public var credentials: PushoverClientCredentials
    
    init(withCredentials creds: PushoverClientCredentials) {
        credentials = creds
    }
    
    public func send(message: PushoverMessage, onSuccess: @escaping (Data)->Void, onError: @escaping (Error)->Void) {
        var sendMessageRequest = URLRequest(url: PushoverClient.sendMessageURL)
        sendMessageRequest.httpMethod = "POST"
        sendMessageRequest.httpBody = (
            credentials.asHttpBodyString() + "&" +
            message.asHttpBodyString()
        ).data(using: .utf8)
        
        let sendMessageTask = URLSession.shared.dataTask(with: sendMessageRequest) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                return onError(error ?? APIError.unknown)
            }
            guard (200 ... 299) ~= response.statusCode else {
                return onError(APIError.statusCode(response.statusCode))
            }
            onSuccess(data)
        }
        sendMessageTask.resume()
    }
    
}

var credentials = PushoverClientCredentials()

if  let path = Bundle.main.url(forResource:"PushoverCredentials", withExtension: "json"),
    let contents = try? Data(contentsOf: path),
    let credentialsFileData = try? JSONSerialization.jsonObject(with: contents, options: []) {
        credentials.userKey = (credentialsFileData as? [String:String])?["key"] ?? ""
        credentials.appToken = (credentialsFileData as? [String:String])?["token"] ?? ""
}
    
if credentials.userKey == "" { exit(0) }

let myPushoverClient = PushoverClient(withCredentials: credentials)

let myMessage = PushoverMessage(message: "Do you read me?", title: "TitledMessage")

myPushoverClient.send(message: myMessage, onSuccess: { data in
    let responseString = String(data: data, encoding: .utf8)
    print("responseString = \(responseString ?? "")")
}, onError: { error in
    print("error: \(error)")
})
