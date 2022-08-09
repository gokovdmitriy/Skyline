//
//  TestViewController.swift
//  Skyline
//
//  Created by MacBook Pro  on 28.07.2022.
//

import Foundation
import UIKit
import SideMenu
import Locksmith

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var newPassword: UITextField!
   
    @IBOutlet weak var newPasswordConfirmed: UITextField!
    
    @IBAction func changePasswordButtonPressed(_ sender: Any) {
    }
    
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

    func changePassword(){
        
            
        }
    }

