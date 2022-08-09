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
    var dayFee : Double
    
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
}
var userInternetServicesInfoInternetPlus = UserInternetServicesModel(cid: "",
                                                                     uid: 0,
                                                                     monthFee: 0,
                                                                     tpName: "",
                                                                     loginStatus: 0,
                                                                     id: 0,
                                                                     internetStatus: 0,
                                                                     tpId: 0,
                                                                     dayFee: 100)
