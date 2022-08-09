//
//  UsersInfo.swift
//  Skyline
//
//  Created by MacBook Pro  on 17.07.2022.
//

import UIKit
import SideMenu

class RefillByCardViewController: UIViewController {
    

    @IBAction func activatePinCodeButtonPressed(_ sender: UIButton) {
    }
    
    @IBOutlet weak var pinCode: UITextField!
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        refillByPinCode()
        menu = SideMenuNavigationController(rootViewController: MenuListTableViewController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
    }

    @IBAction func didTapMenu(_ sender: Any) {
        present(menu!, animated: true)
        
    }
    //MARK: - Refill by code
    func refillByPinCode(){
        
    }
    
    //MARK: - Refill by credit card with Liqpay
    
    
}
