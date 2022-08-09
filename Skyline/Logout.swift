
import UIKit
import SideMenu
import Locksmith

class Logout: UIViewController {
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        menu = SideMenuNavigationController(rootViewController: MenuListTableViewController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }

    @IBAction func didTapMenu(_ sender: Any) {
        present(menu!, animated: true)
        
    }
    


//MARK: - delete password from keychain by Button Exit

func deleteLoginPasswordFromKeychain(){
    do {
        try Locksmith.deleteDataForUserAccount(userAccount: "SavedAccount")
        let loginAndPasswordSaved = false
        let userDefaults = UserDefaults.standard
        userDefaults.set(loginAndPasswordSaved, forKey: "loginAndPasswordSaved")
        userDefaults.resetSavedData()
        
    } catch {
        print("Unable to delete")
    }
}

//MARK: - Change password

}
