//    personalInformation struct


//    "city": "Харьков",
//    "contractId": "206-1-06",
//    "phone": "0632344917",
//    "uid": 569,
//    "email": "d_gokov@mail.ru",
//    "addressFull": " Мира ул. (92+), 92/1, 31",
//    "fio": "Гоков Дмитрий Вадимович",

import Alamofire
import Foundation
import SwiftUI
import RealmSwift

class AutorizationScreen: UIViewController {
    var personalInformation = PersonalInformation()
    var login: String = "Olejik"
    var password: String = "DKSR6JRGSK"
    var loginUidSid = GetUIDFromSkyline(sid: "", login: "", uid: 0)
    
    let myCompletionHandler: (Bool) -> Void = { doneWorking in
        if doneWorking {
            print("loginpasswd sent")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AutorizationScreen")
        passwordAutorization()
        print(personalInformation)
        
    }
    
    // MARK: getUID
    func passwordAutorization(){
        
        let url: String = "https://skystat.com/api.cgi/users/login"
        let parameters: [String: String] = [
            "login": login,
            "password": password]
        
        AF.request(url,method: .post,parameters: parameters, encoder: JSONParameterEncoder.default).responseJSON { [self] response in
            let jsonDecoder = JSONDecoder()
            do
            {
                let responseModel = try! jsonDecoder.decode(GetUIDFromSkyline.self, from: response.data!)
                self.loginUidSid.uid = responseModel.uid
                self.loginUidSid.login = responseModel.login
                self.loginUidSid.sid = responseModel.sid
                self.myCompletionHandler(true)
            }
            self.getUserInformationWithSid(using: myCompletionHandler)
        }
        
    }
    // MARK: GET DETAILS
    
    func getUserInformationWithSid(using completionHandler: (Bool) -> Void){
        let urlGetDetails: String = "https://skystat.com/api.cgi/user/"+String(loginUidSid.uid)+"/pi"
        
        var headers: HTTPHeaders = [
            "USERSID": loginUidSid.sid,
            "content-type": "application/json; charset=utf8"
        ]
        
        AF.request(urlGetDetails, headers: headers).responseJSON { responseSecond in
            
            let jsonDecoder = JSONDecoder()
            do
            {
                let responseModelUserInfo = try! jsonDecoder.decode(UserDetailsInformation.self, from: responseSecond.data!)
                
                self.personalInformation.fio = responseModelUserInfo.fio
                self.personalInformation.login = self.loginUidSid.login
                self.personalInformation.city = responseModelUserInfo.city
                self.personalInformation.contractId = responseModelUserInfo.contractId
                self.personalInformation.phone = responseModelUserInfo.phone
                self.personalInformation.uid = responseModelUserInfo.uid
                self.personalInformation.email = responseModelUserInfo.email
                self.personalInformation.addressFull = responseModelUserInfo.addressFull
                print(self.personalInformation)
                
            }
        }
    }
}





























