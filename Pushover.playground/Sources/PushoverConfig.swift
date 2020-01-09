// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//	 let pushoverConfig = try PushoverConfig(json)

import Foundation

// MARK: - PushoverConfig
public struct PushoverConfig: Codable {
	public let userKey: String
	public let applications: [PushoverApplication]
	public let deliveryGroups: [DeliveryGroup]
	public let devices, emailAliases: [String]

	public enum CodingKeys: String, CodingKey {
		case userKey = "user_key"
		case applications
		case deliveryGroups = "delivery_groups"
		case devices
		case emailAliases = "email_aliases"
	}
}

// MARK: PushoverConfig convenience initializers and mutators

public extension PushoverConfig {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(PushoverConfig.self, from: data)
	}

	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		userKey: String? = nil,
		applications: [PushoverApplication]? = nil,
		deliveryGroups: [DeliveryGroup]? = nil,
		devices: [String]? = nil,
		emailAliases: [String]? = nil
	) -> PushoverConfig {
		return PushoverConfig(
			userKey: userKey ?? self.userKey,
			applications: applications ?? self.applications,
			deliveryGroups: deliveryGroups ?? self.deliveryGroups,
			devices: devices ?? self.devices,
			emailAliases: emailAliases ?? self.emailAliases
		)
	}

	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

// MARK: - PushoverApplication
public struct PushoverApplication: Codable {
	public let name, token, iconID: String

	public enum CodingKeys: String, CodingKey {
		case name, token
		case iconID = "icon_id"
	}
}

// MARK: PushoverApplication convenience initializers and mutators

public extension PushoverApplication {
    init(data: Data) throws {
		self = try newJSONDecoder().decode(PushoverApplication.self, from: data)
	}

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

    init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

    func with(
		name: String? = nil,
		token: String? = nil,
		iconID: String? = nil
	) -> PushoverApplication {
		return PushoverApplication(
			name: name ?? self.name,
			token: token ?? self.token,
			iconID: iconID ?? self.iconID
		)
	}

    func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

// MARK: - DeliveryGroup
public struct DeliveryGroup: Codable {
	public let name, groupKey: String

	public enum CodingKeys: String, CodingKey {
		case name
		case groupKey = "group_key"
	}
}

// MARK: DeliveryGroup convenience initializers and mutators

public extension DeliveryGroup {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(DeliveryGroup.self, from: data)
	}

	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		name: String? = nil,
		groupKey: String? = nil
	) -> DeliveryGroup {
		return DeliveryGroup(
			name: name ?? self.name,
			groupKey: groupKey ?? self.groupKey
		)
	}

	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

// MARK: - Helper functions for creating encoders and decoders

public func newJSONDecoder() -> JSONDecoder {
	let decoder = JSONDecoder()
	if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
		decoder.dateDecodingStrategy = .iso8601
	}
	return decoder
}

public func newJSONEncoder() -> JSONEncoder {
	let encoder = JSONEncoder()
	if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
		encoder.dateEncodingStrategy = .iso8601
	}
	return encoder
}
