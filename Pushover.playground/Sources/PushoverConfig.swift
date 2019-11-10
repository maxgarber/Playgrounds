// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//	 let pushoverConfig = try PushoverConfig(json)

import Foundation

// MARK: - PushoverConfig
public struct PushoverConfig: Codable ***REMOVED***
	public let userKey: String
	public let applications: [PushoverApplication]
	public let deliveryGroups: [DeliveryGroup]
	public let devices, emailAliases: [String]

	public enum CodingKeys: String, CodingKey ***REMOVED***
		case userKey = "user_key"
		case applications
		case deliveryGroups = "delivery_groups"
		case devices
		case emailAliases = "email_aliases"
	***REMOVED***
***REMOVED***

// MARK: PushoverConfig convenience initializers and mutators

public extension PushoverConfig ***REMOVED***
	init(data: Data) throws ***REMOVED***
		self = try newJSONDecoder().decode(PushoverConfig.self, from: data)
	***REMOVED***

	init(_ json: String, using encoding: String.Encoding = .utf8) throws ***REMOVED***
		guard let data = json.data(using: encoding) else ***REMOVED***
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		***REMOVED***
		try self.init(data: data)
	***REMOVED***

	init(fromURL url: URL) throws ***REMOVED***
		try self.init(data: try Data(contentsOf: url))
	***REMOVED***

	func with(
		userKey: String? = nil,
		applications: [PushoverApplication]? = nil,
		deliveryGroups: [DeliveryGroup]? = nil,
		devices: [String]? = nil,
		emailAliases: [String]? = nil
	) -> PushoverConfig ***REMOVED***
		return PushoverConfig(
			userKey: userKey ?? self.userKey,
			applications: applications ?? self.applications,
			deliveryGroups: deliveryGroups ?? self.deliveryGroups,
			devices: devices ?? self.devices,
			emailAliases: emailAliases ?? self.emailAliases
		)
	***REMOVED***

	func jsonData() throws -> Data ***REMOVED***
		return try newJSONEncoder().encode(self)
	***REMOVED***

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? ***REMOVED***
		return String(data: try self.jsonData(), encoding: encoding)
	***REMOVED***
***REMOVED***

// MARK: - PushoverApplication
public struct PushoverApplication: Codable ***REMOVED***
	public let name, token, iconID: String

	public enum CodingKeys: String, CodingKey ***REMOVED***
		case name, token
		case iconID = "icon_id"
	***REMOVED***
***REMOVED***

// MARK: PushoverApplication convenience initializers and mutators

public extension PushoverApplication ***REMOVED***
    init(data: Data) throws ***REMOVED***
		self = try newJSONDecoder().decode(PushoverApplication.self, from: data)
	***REMOVED***

    init(_ json: String, using encoding: String.Encoding = .utf8) throws ***REMOVED***
		guard let data = json.data(using: encoding) else ***REMOVED***
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		***REMOVED***
		try self.init(data: data)
	***REMOVED***

    init(fromURL url: URL) throws ***REMOVED***
		try self.init(data: try Data(contentsOf: url))
	***REMOVED***

    func with(
		name: String? = nil,
		token: String? = nil,
		iconID: String? = nil
	) -> PushoverApplication ***REMOVED***
		return PushoverApplication(
			name: name ?? self.name,
			token: token ?? self.token,
			iconID: iconID ?? self.iconID
		)
	***REMOVED***

    func jsonData() throws -> Data ***REMOVED***
		return try newJSONEncoder().encode(self)
	***REMOVED***

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? ***REMOVED***
		return String(data: try self.jsonData(), encoding: encoding)
	***REMOVED***
***REMOVED***

// MARK: - DeliveryGroup
public struct DeliveryGroup: Codable ***REMOVED***
	public let name, groupKey: String

	public enum CodingKeys: String, CodingKey ***REMOVED***
		case name
		case groupKey = "group_key"
	***REMOVED***
***REMOVED***

// MARK: DeliveryGroup convenience initializers and mutators

public extension DeliveryGroup ***REMOVED***
	init(data: Data) throws ***REMOVED***
		self = try newJSONDecoder().decode(DeliveryGroup.self, from: data)
	***REMOVED***

	init(_ json: String, using encoding: String.Encoding = .utf8) throws ***REMOVED***
		guard let data = json.data(using: encoding) else ***REMOVED***
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		***REMOVED***
		try self.init(data: data)
	***REMOVED***

	init(fromURL url: URL) throws ***REMOVED***
		try self.init(data: try Data(contentsOf: url))
	***REMOVED***

	func with(
		name: String? = nil,
		groupKey: String? = nil
	) -> DeliveryGroup ***REMOVED***
		return DeliveryGroup(
			name: name ?? self.name,
			groupKey: groupKey ?? self.groupKey
		)
	***REMOVED***

	func jsonData() throws -> Data ***REMOVED***
		return try newJSONEncoder().encode(self)
	***REMOVED***

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? ***REMOVED***
		return String(data: try self.jsonData(), encoding: encoding)
	***REMOVED***
***REMOVED***

// MARK: - Helper functions for creating encoders and decoders

public func newJSONDecoder() -> JSONDecoder ***REMOVED***
	let decoder = JSONDecoder()
	if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) ***REMOVED***
		decoder.dateDecodingStrategy = .iso8601
	***REMOVED***
	return decoder
***REMOVED***

public func newJSONEncoder() -> JSONEncoder ***REMOVED***
	let encoder = JSONEncoder()
	if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) ***REMOVED***
		encoder.dateEncodingStrategy = .iso8601
	***REMOVED***
	return encoder
***REMOVED***
