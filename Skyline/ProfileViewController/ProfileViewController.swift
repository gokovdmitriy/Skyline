//https://skystat.com/api.cgi/user/570/internet/94/warnings

import Locksmith
import SideMenu
import Alamofire
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var fiolabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var agreementLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var depositLabel: UILabel!
    
    @IBOutlet weak var fioStack: UIStackView!
    @IBOutlet weak var loginStack: UIStackView!
    @IBOutlet weak var uidStack: UIStackView!
    @IBOutlet weak var emailStack: UIStackView!
    @IBOutlet weak var addressStack: UIStackView!
    @IBOutlet weak var cityStack: UIStackView!
    @IBOutlet weak var phoneStack: UIStackView!
    @IBOutlet weak var agreementStack: UIStackView!
    @IBOutlet weak var statusStack: UIStackView!
    @IBOutlet weak var depositStack: UIStackView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var personalInformationProfile = PersonalInformation()
    var loginUidSidProfile = GetUIDFromSkyline(sid: "", login: "", uid: 0)
    var userInternetServicesInfoProfile = UserInternetServicesModel(cid: "",
                                                                    uid: 0,
                                                                    monthFee: 0,
                                                                    tpName: "",
                                                                    loginStatus: 0,
                                                                    id: 0,
                                                                    internetStatus: 0,
                                                                    tpId: 0,
                                                                    dayFee: 0)
    
    var myCompletionHandlerProfile: (Bool) -> Void = { doneWorking in
        if doneWorking {
            print("loginpasswd sent")
        }
    }
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        menu = SideMenuNavigationController(rootViewController: MenuListTableViewController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        profileViewPrinting()
    }
    
    @IBAction func didTapMenu(_ sender: Any) {
        present(menu!, animated: true)
        
    }
        
    func profileViewPrinting(){
        let cornerRadius = loginStack.frame.width/loginStack.frame.height
        
        loginStack.layer.cornerRadius = cornerRadius
        uidStack.layer.cornerRadius = cornerRadius
        emailStack.layer.cornerRadius = cornerRadius
        addressStack.layer.cornerRadius = cornerRadius
        cityStack.layer.cornerRadius = cornerRadius
        phoneStack.layer.cornerRadius = cornerRadius
        agreementStack.layer.cornerRadius = cornerRadius
        statusStack.layer.cornerRadius = cornerRadius
        fioStack.layer.cornerRadius = cornerRadius
        depositStack.layer.cornerRadius = cornerRadius
        
        print(uidStack.layer.cornerRadius)
        print(fioStack.layer.cornerRadius)
        
        fiolabel.text = UserDefaults.standard.string(forKey: "fiolabel")
        loginLabel.text = UserDefaults.standard.string(forKey: "loginLabel")
        cityLabel.text = UserDefaults.standard.string(forKey: "cityLabel")
        phoneLabel.text = UserDefaults.standard.string(forKey: "phoneLabel")
        uidLabel.text = UserDefaults.standard.string(forKey: "uidLabel")
        emailLabel.text = UserDefaults.standard.string(forKey: "emailLabel")
        addressLabel.text = UserDefaults.standard.string(forKey: "addressLabel")
        agreementLabel.text = UserDefaults.standard.string(forKey: "agreementLabel")
        statusLabel.text = UserDefaults.standard.string(forKey: "statusLabel")
        depositLabel.text = UserDefaults.standard.string(forKey: "depositLabel")
        statusStack.backgroundColor = .systemGreen
        
       
        
    }
        
    // MARK: - Get personal information
    
    func getUserInformationWithSid(using completionHandler: (Bool) -> Void){
        
        let urlGetDetails: String = "https://skystat.com/api.cgi/user/"+String(loginUidSidProfile.uid)+"/pi"
        
        let headers: HTTPHeaders = [
            "USERSID": loginUidSidProfile.sid,
            //"content-type": "application/json; charset=utf8"
        ]
        
        AF.request(urlGetDetails, headers: headers).responseJSON { responseSecond in
            
            let jsonDecoder = JSONDecoder()
            do
            {
                let responseModelUserInfo = try! jsonDecoder.decode(UserDetailsInformation.self,
                                                                    from: responseSecond.data!)
                
                self.fiolabel.text = responseModelUserInfo.fio
                self.loginLabel.text = self.loginUidSidProfile.login
                self.cityLabel.text = responseModelUserInfo.city
                self.agreementLabel.text = responseModelUserInfo.contractId
                self.phoneLabel.text = responseModelUserInfo.phone
                self.uidLabel.text = String(responseModelUserInfo.uid)
                self.emailLabel.text = responseModelUserInfo.email
                self.addressLabel.text = responseModelUserInfo.addressFull
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(self.fiolabel.text, forKey: "fiolabel")
                userDefaults.set(self.loginLabel.text, forKey: "loginLabel")
                userDefaults.set(self.cityLabel.text, forKey: "cityLabel")
                userDefaults.set(self.phoneLabel.text, forKey: "phoneLabel")
                userDefaults.set(self.uidLabel.text, forKey: "uidLabel")
                userDefaults.set(self.emailLabel.text, forKey: "emailLabel")
                userDefaults.set(self.addressLabel.text, forKey: "addressLabel")
                userDefaults.set(self.agreementLabel.text, forKey: "agreementLabel")
                
            }
        }
    }
    //MARK: - UserInternetServicesInfo
    
    func getUserInternetServicesInfo(using completionHandler: (Bool) -> Void){
        
        let urlGetUsrIntServInfo: String = "https://skystat.com/api.cgi/user/"+String(loginUidSidProfile.uid)+"/internet"
        
        let headersIntServInfo: HTTPHeaders = [
            "USERSID": loginUidSidProfile.sid,
            "content-type": "application/json; charset=utf8"
        ]
        AF.request(urlGetUsrIntServInfo, headers: headersIntServInfo).responseJSON { [self] responseInternetServices in
            
            let jsonDecoder = JSONDecoder()
            do
            {
                let responseModelInternetServices = try! jsonDecoder.decode([UserInternetServicesModel].self,
                                                                            from: responseInternetServices.data!)
                
                self.userInternetServicesInfoProfile = responseModelInternetServices[0]
                userInternetServicesInfoInternetPlus = responseModelInternetServices[0]
                let internetStatus = self.userInternetServicesInfoProfile.internetStatus
                if internetStatus == 0{
                    statusLabel.text = "Активно"
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(self.statusLabel.text, forKey: "statusLabel")
                    
                }else{
                    statusLabel.text = "Не активно"
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(self.statusLabel.text, forKey: "statusLabel")
                        statusStack.backgroundColor = .red
                    
                }
            }
        }
    }
    //MARK: - DepositInfo
    
    func getDepositInformation(using completionHandler: (Bool) -> Void){
        
        let urlGetDepositInfo: String = "https://skystat.com/api.cgi/user/" + String(loginUidSidProfile.uid)
        
        let headersIntServInfo: HTTPHeaders = [
            "USERSID": loginUidSidProfile.sid,
            "content-type": "application/json; charset=utf8"
        ]
        AF.request(urlGetDepositInfo, headers: headersIntServInfo).responseJSON { [self] responseInternetServices in
            
            let jsonDecoder = JSONDecoder()
            do
            {
                let responseModelToGetDeposit = try! jsonDecoder.decode(DepositInformation.self,
                                                                        from: responseInternetServices.data!)
                userDepositInformation.deposit = responseModelToGetDeposit.deposit
                depositLabel.text = String(userDepositInformation.deposit) + " грн"
                let userDefaults = UserDefaults.standard
                userDefaults.set(self.depositLabel.text, forKey: "depositLabel")
            }
        }
        let urlGetWarning: String = "https://skystat.com/api.cgi/user/" + String(loginUidSidProfile.uid) + "/internet/" + String(self.userInternetServicesInfoProfile.id) + "/warnings"
        
        AF.request(urlGetWarning, headers: headersIntServInfo).responseJSON { [self] responseInternetServices in
            
            let jsonDecoder = JSONDecoder()
            do
            {
                let responseModelToGetDaysToExpire = try! jsonDecoder.decode(WarningDaysToExpire.self,
                                                                             from: responseInternetServices.data!)
                daysToExpire.warning = responseModelToGetDaysToExpire.warning
            }
        }
    }
}
