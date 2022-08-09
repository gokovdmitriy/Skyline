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
}
