import Foundation

fileprivate func getSecret(for key: String) -> String {
    if let jobj = try? JSON_Object(with: Data(contentsOf: Bundle.main.url(forResource: "secrets", withExtension: "json")!)) {
        if let val = jobj.valueFor(keypath: "OpenWeatherMap." + key) as? String {
            return val
        } else {
            return ""
        }
    }
    return ""
}

public func createURL(fromString: String, withQueryItems queryDict: [String:String]) -> URL? {
    var urlComponents = URLComponents(url: URL(string: fromString)!, resolvingAgainstBaseURL: false)!
    let queryItems = queryDict.map({
        return URLQueryItem(name: "\($0)", value: "\($1)")
    })
    urlComponents.queryItems = queryItems
    return urlComponents.url
}

// @todo: how to abstract away the structure of the data? e.g. value, units, vector-values, ...

public enum DataProviderError: Error {
    case unsupportedOperation(String)
    case other(String)
}

public protocol DataProvider {
    typealias DataIdentifier = String
    var baseURL: URL { get }
    var requiresAuth: Bool { get }
    var availableDataIdentifiers: [DataIdentifier] { get }
    
    func getData(for dataIdentifier: DataIdentifier,
                 with context: [String:Any],
                 onSuccess successHandler: @escaping ((Any)->Void),
                 onFailure failureHandler: @escaping ((Error)->Void)
    )
}


public class USGSWaterServices: DataProvider {
    public var baseURL: URL = URL(string:"https://waterservices.usgs.gov/nwis/iv/")!
    public var requiresAuth: Bool = false
    public var availableDataIdentifiers: [DataIdentifier] = [ "WaterTemperature" ]
    private let dataFetchingParameters: [DataIdentifier : [String : String]] = [
        "WaterTemperature": [
            "format" : "json",
            "sites": "03049640",        // Allegheny River
            "parameterCd": "00010",     // temperature, ˚C
            "siteStatus": "all"
        ]
    ]
    
    public init() {}
    
    public func getData(for dataIdentifier: DataIdentifier,
                        with context: [String : Any],
                        onSuccess successHandler: @escaping ((Any) -> Void),
                        onFailure failureHandler: @escaping ((Error) -> Void)
    ) {
        guard availableDataIdentifiers.contains(dataIdentifier) else {
            failureHandler( DataProviderError.unsupportedOperation("No such data identifier as \(dataIdentifier)") )
            return
        }
        guard let requestParams = dataFetchingParameters[dataIdentifier],
                let requestURL = createURL(fromString: baseURL.absoluteString, withQueryItems: requestParams) else {
            failureHandler( DataProviderError.unsupportedOperation("Could not compose request URL") )
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                failureHandler( error )
                return
            }
        
            guard let httpResponse = response as? HTTPURLResponse else {
                failureHandler( DataProviderError.other("No HTTP response") )
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                failureHandler( DataProviderError.other("Bad HTTP status code: \(httpResponse.statusCode)") )
                return
            }

            guard let data = data else {
                failureHandler( DataProviderError.other("No data returned") )
                return
            }
        
            let jsonObject = JSON_Object(with: data)
            if let flowRate = jsonObject["value.timeSeries[0].values[0].value[0].value"] as? String {
                successHandler( flowRate )
            } else {
                failureHandler( DataProviderError.other("Could not parse data") )
            }
        }
        task.resume()
    }
}

public class OpenWeatherMap: DataProvider {
    public var baseURL: URL = URL(string: "http://api.openweathermap.org/data/2.5/weather")!
    
    public var requiresAuth = true
    
    public var availableDataIdentifiers: [DataIdentifier] = [ "WindVector" ]
    
    private let dataFetchingParameters: [DataIdentifier : [String : String]] = [
        "WindVector": ["q": "Pittsburgh", "APPID": getSecret(for: "APPID")]
    ]
    
    public init() {}
    
    public func getData(for dataIdentifier: DataIdentifier,
                        with context: [String : Any],
                        onSuccess successHandler: @escaping ((Any) -> Void),
                        onFailure failureHandler: @escaping ((Error) -> Void)
    ) {
        guard availableDataIdentifiers.contains(dataIdentifier) else {
            failureHandler( DataProviderError.unsupportedOperation("No such data identifier as \(dataIdentifier)") )
            return
        }
        guard let requestParams = dataFetchingParameters[dataIdentifier],
                let requestURL = createURL(fromString: baseURL.absoluteString, withQueryItems: requestParams) else {
            failureHandler( DataProviderError.unsupportedOperation("Could not compose request URL") )
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                failureHandler( error )
                return
            }
        
            guard let httpResponse = response as? HTTPURLResponse else {
                failureHandler( DataProviderError.other("No HTTP response") )
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                failureHandler( DataProviderError.other("Bad HTTP status code: \(httpResponse.statusCode)") )
                return
            }

            guard let data = data else {
                failureHandler( DataProviderError.other("No data returned") )
                return
            }
        
            let jsonObject = JSON_Object(with: data)
            
            if  let windSpeed = jsonObject.valueFor(keypath: "wind.speed") as? Double,
                let windDirxn = jsonObject.valueFor(keypath: "wind.deg") as? Double,
                let airTempK = jsonObject.valueFor(keypath: "main.temp") as? Double
            {
                let airSpeed = windSpeed * (360/1609.34)    // mph
                let airTempC = airTempK - 273.15            // ˚C
                var airDirxn: String
                switch (windDirxn) {
                case (0..<23): airDirxn = "E"; break
                case (22..<67): airDirxn = "NE"; break
                case (67..<112): airDirxn = "N"; break
                case (112..<157): airDirxn = "NW"; break
                case (157..<202): airDirxn = "W"; break
                case (202..<247): airDirxn = "SW"; break
                case (247..<292): airDirxn = "S"; break
                case (292..<337): airDirxn = "SE"; break
                case (337...360): airDirxn = "E"; break
                default: airDirxn = "??"
                }
                successHandler( (tempC: airTempC, speed: airSpeed, dirxn: airDirxn) )
            } else {
                successHandler( data )
            }
        }
        task.resume()
    }
}

public class NWSWaterData: DataProvider {
    public var baseURL: URL = URL(string:"https://water.weather.gov/ahps2/hydrograph_to_xml.php")!
    
    public var requiresAuth: Bool = false
    
    public var availableDataIdentifiers: [DataIdentifier] = [ "WaterFlow" ]
    
    private let dataFetchingParameters: [DataIdentifier : [String : String]] = [
        "WaterFlow": [ "output" : "xml",  "gage": "shrp1" ]
    ]
    
    public init() {}
    
    public func getData(for dataIdentifier: DataIdentifier,
                        with context: [String : Any],
                        onSuccess successHandler: @escaping ((Any) -> Void),
                        onFailure failureHandler: @escaping ((Error) -> Void)
    ) {
        guard availableDataIdentifiers.contains(dataIdentifier) else {
            failureHandler( DataProviderError.unsupportedOperation("No such data identifier as \(dataIdentifier)") )
            return
        }
        guard let requestParams = dataFetchingParameters[dataIdentifier],
                let requestURL = createURL(fromString: baseURL.absoluteString, withQueryItems: requestParams) else {
            failureHandler( DataProviderError.unsupportedOperation("Could not compose request URL") )
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                failureHandler( error )
                return
            }
        
            guard let httpResponse = response as? HTTPURLResponse else {
                failureHandler( DataProviderError.other("No HTTP response") )
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                failureHandler( DataProviderError.other("Bad HTTP status code: \(httpResponse.statusCode)") )
                return
            }

            guard let data = data else {
                failureHandler( DataProviderError.other("No data returned") )
                return
            }
        
            if  let xmlDoc = try? XMLDocument(data: data, options: []),
                let root = xmlDoc.rootElement(),
                let flow = try? root.nodes(forXPath: "/site/observed/datum[1]/primary")[0].stringValue,
                let flood = try? root.nodes(forXPath: "/site/observed/datum[1]/secondary")[0].stringValue {
                successHandler( (flow: flow, flood: flood) )
            }
        }
        task.resume()
    }
}


let waterTempProvider = USGSWaterServices()
let waterFlowProvider = NWSWaterData()
let weatherProvider = OpenWeatherMap()

waterTempProvider.getData(for: waterTempProvider.availableDataIdentifiers[0], with: [:], onSuccess: { temp in
	print("water temperature is \(temp) ˚C")
}, onFailure: { error in
    print("encountered an error, \(error)")
})


waterFlowProvider.getData(for: waterFlowProvider.availableDataIdentifiers[0], with: [:], onSuccess: { data in
    if let flowAndFlood = data as? (flow:String,flood:String) {
        print("water flow is \(flowAndFlood.flow) kcfs")
        print("water height is \(flowAndFlood.flood) ft")
    } else {
        print("data was: \(data)")
    }
}, onFailure: { error in
    print("encountered an error: \(error)")
})


weatherProvider.getData(for: weatherProvider.availableDataIdentifiers[0], with: [:], onSuccess: { data in
    if let tuple = data as? (tempC: Double, speed: Double, dirxn: String) {
        print("air temperature: \(tuple.tempC) ˚C")
        print("wind speed: \(tuple.speed) mph, \(tuple.dirxn)")
    } else if let data = data as? Data {
        let text = String(data: data, encoding: .utf8)
        print(text ?? "oops")
    }
}, onFailure: { error in
    print("encountered an error: \(error)")
})

