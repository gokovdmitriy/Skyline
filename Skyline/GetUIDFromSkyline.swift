import Foundation
struct GetUIDFromSkyline : Codable {
    var sid : String
    var login : String
    var uid : Int

	enum CodingKeys: String, CodingKey {

		case sid = "sid"
		case login = "login"
		case uid = "uid"
	}

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		sid = try values.decodeIfPresent(String.self, forKey: .sid)
//		login = try values.decodeIfPresent(String.self, forKey: .login)
//		uid = try values.decodeIfPresent(Int.self, forKey: .uid)
//	}

}
