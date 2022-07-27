//    personalInformation struct
//     login kagor
//    "city": "Харьков",
//    "contractId": "206-1-06",
//    "phone": "0632344917",
//    "uid": 569,
//    "email": "d_gokov@mail.ru",
//    "addressFull": " Мира ул. (92+), 92/1, 31",
//    "fio": "Гоков Дмитрий Вадимович",
import Foundation

struct PersonalInformation : Codable {
    
    var login : String = ""
    var city: String = ""
    var contractId: String = ""
    var phone: String = ""
    var uid: Int = 0
    var email: String = ""
    var addressFull: String = ""
    var fio: String = ""
    
}
