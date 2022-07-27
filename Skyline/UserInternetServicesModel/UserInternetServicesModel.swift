import Foundation

struct UserInternetServicesModel : Codable {
	var cid : String
    var uid : Int
    var monthFee : Int
    var tpName : String
    var loginStatus : Int
    var id : Int
    var internetStatus : Int
    var tpId : Int
    var dayFee : Int

	enum CodingKeys: String, CodingKey {

		case cid = "cid"
		case uid = "uid"
		case monthFee = "monthFee"
		case tpName = "tpName"
		case loginStatus = "loginStatus"
		case id = "id"
		case internetStatus = "internetStatus"
		case tpId = "tpId"
		case dayFee = "dayFee"
	}

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		cid = try values.decodeIfPresent(String.self, forKey: .cid)
//		uid = try values.decodeIfPresent(Int.self, forKey: .uid)
//		monthFee = try values.decodeIfPresent(Int.self, forKey: .monthFee)
//		tpName = try values.decodeIfPresent(String.self, forKey: .tpName)
//		loginStatus = try values.decodeIfPresent(Int.self, forKey: .loginStatus)
//		id = try values.decodeIfPresent(Int.self, forKey: .id)
//		internetStatus = try values.decodeIfPresent(Int.self, forKey: .internetStatus)
//		tpId = try values.decodeIfPresent(Int.self, forKey: .tpId)
//		dayFee = try values.decodeIfPresent(Int.self, forKey: .dayFee)
//	}

}
