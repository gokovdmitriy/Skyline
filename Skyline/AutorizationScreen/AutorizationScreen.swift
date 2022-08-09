import Alamofire
import Foundation
import SwiftUI
import LocalAuthentication
import Locksmith

class AutorizationScreen: UIViewController {
    
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
    
    
    
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
    
    //MARK: - Handlers
    
    let myCompletionHandler: (Bool) -> Void = { doneWorking in
        if doneWorking {
            print("loginpasswd sent")
        }
    }
    
    let readyToPushHandler: (Bool) -> Void = { doneWorking in
        if doneWorking {
            print("ready to send")
        }
    }
    
    // MARK: - passwordAutorization to get UID
    
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
                
            }
            pushToProfileViewController(using: readyToPushHandler)
        }
        
    }
    
    //MARK: - push to ProfileViewController
    
    func pushToProfileViewController(using readyToPushHandler: (Bool) -> Void){
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = main.instantiateViewController(withIdentifier: "ProfileViewController")
            as? ProfileViewController {
            viewController.loginUidSidProfile = self.loginUidSid
            viewController.myCompletionHandlerProfile = self.myCompletionHandler
            viewController.getUserInformationWithSid(using: viewController.myCompletionHandlerProfile)
            viewController.getUserInternetServicesInfo(using: viewController.myCompletionHandlerProfile)
            viewController.getDepositInformation(using: viewController.myCompletionHandlerProfile)
            self.navigationController?.pushViewController(viewController, animated: true)
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
            }))
            
            askingForSaveAlert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            present(askingForSaveAlert, animated: true, completion: nil)
        }
    }
    //MARK: - Button
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if (login.text != "" || password.text != "") {
            
            passwordAutorization()
            saveLoginAndPassword()
            
        }
        else {
            let alert = UIAlertController(title: "Ошибка", message: "Введите логин и пароль ",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - FaceID TouchID
    
    private func FaceIDTouchID() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Идентифицируйте себя"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                
                let userDefaultsGet = UserDefaults.standard
                let newText = userDefaultsGet.object(forKey: "loginAndPasswordSaved") as! Bool
                print(newText)
                if success && newText == true {
                    DispatchQueue.main.async { [unowned self] in
                        print("Успешная авторизация")
                        let savedLoginAndPasswordWithLocksmith = Locksmith.loadDataForUserAccount(userAccount: "SavedAccount")!
                        print(savedLoginAndPasswordWithLocksmith)
                        login.text = savedLoginAndPasswordWithLocksmith["loginToSave"] as? String
                        password.text = savedLoginAndPasswordWithLocksmith ["passwordToSave"] as? String
                        passwordAutorization()
                        saveLoginAndPassword()
                    }
                }
            }
            
        } else {
            print("Face/Touch ID не найден")
        }
    }
}





























