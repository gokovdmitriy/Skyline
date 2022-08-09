//
//  MenuListController.swift
//  Skyline
//
//  Created by MacBook Pro  on 28.07.2022.
//

import Foundation
import UIKit

enum Menu: CaseIterable {
    case userProfile
    case inetPlus
    case cards
    case operations
    case logout
    
    var menuTitle: String {
        switch self {
        case .userProfile: return "Данные пользователя"
        case .inetPlus: return "Интернет+"
        case .cards: return "Карточки пополнения"
        case .operations: return "Настройки"
        case .logout: return "Выход"
        }
    }
    
    var viewControllerIdentifier: String {
        switch self {
        case .userProfile:
            return "ProfileViewController"
        case .operations:
            return "SettingsViewController"
        case .inetPlus:
            return "InternetPlusClassViewController"
        case .cards:
            return "RefillByCardViewController"
        case .logout:
            return "Logout"
        }
    }
}

class MenuListTableViewController: UITableViewController{
    var menuList = Menu.allCases
    
    let color = UIColor(red: 33/255.0,
                        green: 33/255.0,
                        blue: 33/255.0,
                        alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = color
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = color
        cell.textLabel?.text = menuList[indexPath.row].menuTitle
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        if let href = main.instantiateViewController(withIdentifier: menuList[indexPath.row].viewControllerIdentifier) as?
            ProfileViewController {
            self.navigationController?.pushViewController(href, animated: false)
            
        }
        if let href = main.instantiateViewController(withIdentifier: menuList[indexPath.row].viewControllerIdentifier ) as?
            SettingsViewController{
            self.navigationController?.pushViewController(href, animated: false)
        }
        if let href = main.instantiateViewController(withIdentifier: menuList[indexPath.row].viewControllerIdentifier) as?
            InternetPlusClassViewController{
            self.navigationController?.pushViewController(href, animated: false)
        }
        if let href = main.instantiateViewController(withIdentifier: menuList[indexPath.row].viewControllerIdentifier) as?
            RefillByCardViewController{
            self.navigationController?.pushViewController(href, animated: false)
        }
        if let href = main.instantiateViewController(withIdentifier: menuList[indexPath.row].viewControllerIdentifier) as?
            Logout{
            href.deleteLoginPasswordFromKeychain()
            if let AutorizationScreenPush = main.instantiateViewController(withIdentifier: "AutorizationScreen") as?
                AutorizationScreen{
                self.navigationController?.pushViewController(AutorizationScreenPush, animated: false)
            }
        }
    }
}
