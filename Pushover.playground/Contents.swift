import Foundation


var credentials = PushoverClientCredentials()

if let path = Bundle.main.url(forResource:"PushoverCredentials", withExtension: "json"),
	let contents = try? Data(contentsOf: path)
{
	let secrets = JSON_Object(with: contents)
	
	
	if let key = secrets["user_key"] as? String, let tok = secrets["token"] as? String {
		credentials.userKey = key
		credentials.appToken = tok
	} else {
		fatalError()
	}
} else {
	print("couldn't load credentials")
	fatalError()
}

let myPushoverClient = PushoverClient(withCredentials: credentials)

let myMessage = PushoverMessage(message: "Do you read me?", title: "TitledMessage")

myPushoverClient.send(message: myMessage, onSuccess: { data in
    let responseString = String(data: data, encoding: .utf8)
    print("responseString = \(responseString ?? "")")
}, onError: { error in
    print("error: \(error)")
})
