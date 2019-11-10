import Foundation

var credentials = PushoverClientCredentials()
if let path = Bundle.main.url(forResource: "pushover_config", withExtension: "json"),
    let json = try? String(contentsOf: path),
    let config = try? PushoverConfig(json) ***REMOVED***
    credentials.userKey = config.userKey
    credentials.appToken = config.applications[0].token
***REMOVED*** else ***REMOVED***
    print("could not get credentials from config file")
    exit(0)
***REMOVED***

let myPushoverClient = PushoverClient(withCredentials: credentials)

let myMessage = PushoverMessage(message: "from a Swift playground", title: "Test Message")

myPushoverClient.send(message: myMessage, onSuccess: ***REMOVED*** data in
    let responseString = String(data: data, encoding: .utf8)
    print("responseString = \(responseString ?? "")")
***REMOVED***, onError: ***REMOVED*** error in
    print("error: \(error)")
***REMOVED***)
