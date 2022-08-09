
import Foundation
struct DepositInformation : Codable {
	let deleted : Int
	let expire : String
	let extBillId : Int
	let affected : Int
	var deposit : Double
	let companyCredit : Int
	let list : [String]
	let companyVat : Int
	let billId : Int
	let creditDate : String
	let credit : Int
	let companyId : Int
	let companyName : String
	let reduction : Int
	let login : String
	let domainId : Int
	let reductionDate : String
	let gName : String
	let total : String
	let gid : Int
	let uid : Int
	let activate : String
	let disable : Int
	let registration : String
	let billOwner : Int

	enum CodingKeys: String, CodingKey {

		case deleted = "deleted"
		case expire = "expire"
		case extBillId = "extBillId"
		case affected = "affected"
		case deposit = "deposit"
		case companyCredit = "companyCredit"
		case list = "list"
		case companyVat = "companyVat"
		case billId = "billId"
		case creditDate = "creditDate"
		case credit = "credit"
		case companyId = "companyId"
		case companyName = "companyName"
		case reduction = "reduction"
		case login = "login"
		case domainId = "domainId"
		case reductionDate = "reductionDate"
		case gName = "gName"
		case total = "total"
		case gid = "gid"
		case uid = "uid"
		case activate = "activate"
		case disable = "disable"
		case registration = "registration"
		case billOwner = "billOwner"
	}

}
var userDepositInformation = DepositInformation(deleted: 0, expire: "",
                                                extBillId: 0,
                                                affected: 0,
                                                deposit: 0,
                                                companyCredit: 0,
                                                list: [],
                                                companyVat: 0,
                                                billId: 0,
                                                creditDate: "",
                                                credit: 0,
                                                companyId: 0,
                                                companyName: "",
                                                reduction: 0,
                                                login: "",
                                                domainId: 0,
                                                reductionDate: "",
                                                gName: "",
                                                total: "",
                                                gid: 0, uid: 0, activate: "",
                                                disable: 0,
                                                registration: "",
                                                billOwner: 0)
