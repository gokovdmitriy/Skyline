import Alamofire
import Foundation
import SwiftUI
import LocalAuthentication
import Locksmith

class AutorizationScreen: UIViewController {
    
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if (login.text != "" || password.text != "") {
            
            passwordAutorization()
            saveLoginAndPassword()
            print(personalInformation)
        }
        else {
            let alert = UIAlertController(title: "Ошибка", message: "Введите логин и пароль ",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.image = UIImage(named: "logoImage")
        print("AutorizationScreen")
        
        let savedLoginAndPasswordWithLocksmith = Locksmith.loadDataForUserAccount(userAccount: "SavedAccount")
        if (savedLoginAndPasswordWithLocksmith != nil){
            
            let loginAndPasswordSaved = true
            let userDefaults = UserDefaults.standard
            userDefaults.set(loginAndPasswordSaved, forKey: "loginAndPasswordSaved")
            
            login.text = savedLoginAndPasswordWithLocksmith?["loginToSave"] as? String ?? ""
            password.text = savedLoginAndPasswordWithLocksmith?["passwordToSave"] as? String ?? ""
        } else {
            
            let loginAndPasswordSaved = false
            let userDefaults = UserDefaults.standard
            userDefaults.set(loginAndPasswordSaved, forKey: "loginAndPasswordSaved")
        }
        FaceIDTouchID()
    }
    
    //MARK: - Data to push to screen with personal user`s data
    
    var personalInformation = PersonalInformation()
    var loginUidSid = GetUIDFromSkyline(sid: "", login: "", uid: 0)
    var userInternetServicesInfo = UserInternetServicesModel(cid: "",
                                                             uid: 0,
                                                             monthFee: 0,
                                                             tpName: "",
                                                             loginStatus: 0,
                                                             id: 0,
                                                             internetStatus: 0,
                                                             tpId: 0,
                                                             dayFee: 0)
    let myCompletionHandler: (Bool) -> Void = { doneWorking in
        if doneWorking {
            print("loginpasswd sent")
        }
    }
    // MARK: - getUID
    
    func passwordAutorization(){
        
        let url: String = "https://skystat.com/api.cgi/users/login"
        let parameters: [String: String] = [
            "login": login.text!,
            "password": password.text!]
        
        AF.request(url,method: .post,parameters: parameters,
                   encoder: JSONParameterEncoder.default).responseJSON { [self] response in
            let jsonDecoder = JSONDecoder()
            do
            {
                let responseModel = try! jsonDecoder.decode(GetUIDFromSkyline.self, from: response.data!)
                self.loginUidSid.uid = responseModel.uid
                self.loginUidSid.login = responseModel.login
                self.loginUidSid.sid = responseModel.sid
                self.myCompletionHandler(true)
                print(loginUidSid)
            }
            self.getUserInformationWithSid(using: myCompletionHandler)
            self.getUserInternetServicesInfo(using: myCompletionHandler)
        }
        
    }
    // MARK: - Get personal information
    
    func getUserInformationWithSid(using completionHandler: (Bool) -> Void){
        
        let urlGetDetails: String = "https://skystat.com/api.cgi/user/"+String(loginUidSid.uid)+"/pi"
        
        let headers: HTTPHeaders = [
            "USERSID": loginUidSid.sid,
            "content-type": "application/json; charset=utf8"
        ]
        
        AF.request(urlGetDetails, headers: headers).responseJSON { responseSecond in
            
            let jsonDecoder = JSONDecoder()
            do
            {
                let responseModelUserInfo = try! jsonDecoder.decode(UserDetailsInformation.self,
                                                                    from: responseSecond.data!)
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
    //MARK: - UserInternetServicesInfo
    
    func getUserInternetServicesInfo(using completionHandler: (Bool) -> Void){
        
        let urlGetUsrIntServInfo: String = "https://skystat.com/api.cgi/user/"+String(loginUidSid.uid)+"/internet"
        
        let headersIntServInfo: HTTPHeaders = [
            "USERSID": loginUidSid.sid,
            "content-type": "application/json; charset=utf8"
        ]
        AF.request(urlGetUsrIntServInfo, headers: headersIntServInfo).responseJSON { responseInternetServices in
            
            let jsonDecoder = JSONDecoder()
            do
            {
                let responseModelInternetServices = try! jsonDecoder.decode([UserInternetServicesModel].self,
                                                                            from: responseInternetServices.data!)
                print(responseModelInternetServices)
                self.userInternetServicesInfo = responseModelInternetServices[0]
                print(self.userInternetServicesInfo.cid)
                
            }
        }
    }
    //MARK: - saving Login And Pass
    
    func saveLoginAndPassword(){
        let userDefaultsGet = UserDefaults.standard
        let newText = userDefaultsGet.object(forKey: "loginAndPasswordSaved") as! Bool
        print(newText)
        if newText == false {
            let askingForSaveAlert = UIAlertController(title: "Skyline", message: "Сохранить логин и пароль?",
                                                       preferredStyle: UIAlertController.Style.alert)
            askingForSaveAlert.addAction(UIAlertAction(title: "Да", style: .default,
                                                       handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
                if let loginToSave = self.login.text, let passwordToSave = self.password.text {
                    do {
                        try Locksmith.saveData(data: ["loginToSave" : loginToSave,
                                                      "passwordToSave" : passwordToSave ],
                                               forUserAccount: "SavedAccount") } catch {
                                                   //print("Unable to save")
                                                   return
                                               }
                    
                }
                let passwordSaved = UIAlertController(title: "Saving", message: "Password was saved",
                                                      preferredStyle: UIAlertController.Style.alert)
                passwordSaved.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(passwordSaved, animated: true, completion: nil)
            }))
            
            askingForSaveAlert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            present(askingForSaveAlert, animated: true, completion: nil)
        }
    }
    //MARK: - delete password from keychain
    
    func deleteLoginPasswordFromKeychain(){
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: "SavedAccount")
        } catch {
            print("Unable to delete")
        }
        
    }
    //MARK: FaceID TouchID
    
    private func FaceIDTouchID() {
        //                let context = LAContext()
        //                var error: NSError?
        //
        //                if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        //
        //                    let reason = "Идентифицируйте себя"
        //                    context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
        //
        //                        if success {
        //                            DispatchQueue.main.async { [unowned self] in
        //                                print("Успешная авторизация")
        //                                if Locksmith.loadDataForUserAccount(userAccount: <#T##String#>)
        //                                //if !savedLoginAndPasswordWithLocksmith.isEmpty{
        //                                    let savedLoginAndPasswordWithLocksmith = Locksmith.loadDataForUserAccount(userAccount: "SavedAccount")!
        //                                    print(savedLoginAndPasswordWithLocksmith)
        //                                    login.text = savedLoginAndPasswordWithLocksmith["loginTosave"] as! String
        //                                    password.text = savedLoginAndPasswordWithLocksmith["passwordToSave"] as! String
        //
        //                                //}
        //
        //                            }
        //                        }
        //                    }
        //
        //                } else {
        //                    print("Face/Touch ID не найден")
        //                }
    }
    
    
}





























