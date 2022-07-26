import Foundation
struct UserDetailsInformation : Codable {
	let city : String
	let addressBuild : String
	let contractId : String
	let etazh : Int
	let __Olt : String
	let addressDistrict : String
	let pasportDate : String
	let birthDate : String
	let pasportNum : String
	let phone : String
	let pasportGrant : String
	let total : Int
	let addressFlat : String
	let addressStreetTypeName : String
	let addressStreet2 : String
	let locationId : Int
	let uid : Int
	let _PortOnu : String
	let taxNumber : String
	let countryId : Int
	let zip : String
	let _Port : Int
	let _MacOnu : String
	let coordx : Int
	let affected : Int
	let email : String
	let fio2 : String
	let entrance : Int
	let fio3 : String
	let floor : Int
	let addressStreet : String
	let cableLength : Int
	let addressFull : String
	let fio : String
	let podezd : Int
	let cableOwnerId : Int
	let list : [String]
	let phoneSms : String
	let comments : String
	let contractDate : String
	let streetId : Int
	let districtId : Int
	let _AkciyaId : Int
	let acceptRules : Int
	let contractSufix : String

	enum CodingKeys: String, CodingKey {

		case city = "city"
		case addressBuild = "addressBuild"
		case contractId = "contractId"
		case etazh = "etazh"
		case __Olt = "__Olt"
		case addressDistrict = "addressDistrict"
		case pasportDate = "pasportDate"
		case birthDate = "birthDate"
		case pasportNum = "pasportNum"
		case phone = "phone"
		case pasportGrant = "pasportGrant"
		case total = "total"
		case addressFlat = "addressFlat"
		case addressStreetTypeName = "addressStreetTypeName"
		case addressStreet2 = "addressStreet2"
		case locationId = "locationId"
		case uid = "uid"
		case _PortOnu = "_PortOnu"
		case taxNumber = "taxNumber"
		case countryId = "countryId"
		case zip = "zip"
		case _Port = "_Port"
		case _MacOnu = "_MacOnu"
		case coordx = "coordx"
		case affected = "affected"
		case email = "email"
		case fio2 = "fio2"
		case entrance = "entrance"
		case fio3 = "fio3"
		case floor = "floor"
		case addressStreet = "addressStreet"
		case cableLength = "cableLength"
		case addressFull = "addressFull"
		case fio = "fio"
		case podezd = "podezd"
		case cableOwnerId = "cableOwnerId"
		case list = "list"
		case phoneSms = "phoneSms"
		case comments = "comments"
		case contractDate = "contractDate"
		case streetId = "streetId"
		case districtId = "districtId"
		case _AkciyaId = "_AkciyaId"
		case acceptRules = "acceptRules"
		case contractSufix = "contractSufix"
	}

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		city = try values.decodeIfPresent(String.self, forKey: .city)
//		addressBuild = try values.decodeIfPresent(String.self, forKey: .addressBuild)
//		contractId = try values.decodeIfPresent(String.self, forKey: .contractId)
//		etazh = try values.decodeIfPresent(Int.self, forKey: .etazh)
//		__Olt = try values.decodeIfPresent(String.self, forKey: .__Olt)
//		addressDistrict = try values.decodeIfPresent(String.self, forKey: .addressDistrict)
//		pasportDate = try values.decodeIfPresent(String.self, forKey: .pasportDate)
//		birthDate = try values.decodeIfPresent(String.self, forKey: .birthDate)
//		pasportNum = try values.decodeIfPresent(String.self, forKey: .pasportNum)
//		phone = try values.decodeIfPresent(String.self, forKey: .phone)
//		pasportGrant = try values.decodeIfPresent(String.self, forKey: .pasportGrant)
//		total = try values.decodeIfPresent(Int.self, forKey: .total)
//		addressFlat = try values.decodeIfPresent(String.self, forKey: .addressFlat)
//		addressStreetTypeName = try values.decodeIfPresent(String.self, forKey: .addressStreetTypeName)
//		addressStreet2 = try values.decodeIfPresent(String.self, forKey: .addressStreet2)
//		locationId = try values.decodeIfPresent(Int.self, forKey: .locationId)
//		uid = try values.decodeIfPresent(Int.self, forKey: .uid)
//		_PortOnu = try values.decodeIfPresent(String.self, forKey: ._PortOnu)
//		taxNumber = try values.decodeIfPresent(String.self, forKey: .taxNumber)
//		countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
//		zip = try values.decodeIfPresent(String.self, forKey: .zip)
//		_Port = try values.decodeIfPresent(Int.self, forKey: ._Port)
//		_MacOnu = try values.decodeIfPresent(String.self, forKey: ._MacOnu)
//		coordx = try values.decodeIfPresent(Int.self, forKey: .coordx)
//		affected = try values.decodeIfPresent(Int.self, forKey: .affected)
//		email = try values.decodeIfPresent(String.self, forKey: .email)
//		fio2 = try values.decodeIfPresent(String.self, forKey: .fio2)
//		entrance = try values.decodeIfPresent(Int.self, forKey: .entrance)
//		fio3 = try values.decodeIfPresent(String.self, forKey: .fio3)
//		floor = try values.decodeIfPresent(Int.self, forKey: .floor)
//		addressStreet = try values.decodeIfPresent(String.self, forKey: .addressStreet)
//		cableLength = try values.decodeIfPresent(Int.self, forKey: .cableLength)
//		addressFull = try values.decodeIfPresent(String.self, forKey: .addressFull)
//		fio = try values.decodeIfPresent(String.self, forKey: .fio)
//		podezd = try values.decodeIfPresent(Int.self, forKey: .podezd)
//		cableOwnerId = try values.decodeIfPresent(Int.self, forKey: .cableOwnerId)
//		list = try values.decodeIfPresent([String].self, forKey: .list)
//		phoneSms = try values.decodeIfPresent(String.self, forKey: .phoneSms)
//		comments = try values.decodeIfPresent(String.self, forKey: .comments)
//		contractDate = try values.decodeIfPresent(String.self, forKey: .contractDate)
//		streetId = try values.decodeIfPresent(Int.self, forKey: .streetId)
//		districtId = try values.decodeIfPresent(Int.self, forKey: .districtId)
//		_AkciyaId = try values.decodeIfPresent(Int.self, forKey: ._AkciyaId)
//		acceptRules = try values.decodeIfPresent(Int.self, forKey: .acceptRules)
//		contractSufix = try values.decodeIfPresent(String.self, forKey: .contractSufix)
//	}

}
