
import Foundation
struct WarningDaysToExpire : Codable {
	var messageType : String = ""
	var daysToFee : String = ""
	var abonDate : String? = ""
	var warning : String = ""

	enum CodingKeys: String, CodingKey {

		case messageType = "messageType"
		case daysToFee = "daysToFee"
		case abonDate = "abonDate"
		case warning = "warning"
	}

	

}
var daysToExpire = WarningDaysToExpire()
