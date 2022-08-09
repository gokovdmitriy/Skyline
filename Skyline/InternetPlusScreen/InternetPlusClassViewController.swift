
import UIKit
import SideMenu

class InternetPlusClassViewController: UIViewController {
    
    @IBOutlet weak var navigationBarInternetPlus: UINavigationItem!
    
    @IBOutlet weak var tpNameLabel: UILabel!
    @IBOutlet weak var internetStasusLabel: UILabel!
    @IBOutlet weak var monthFeeLabel: UILabel!
    @IBOutlet weak var dayFeeLabel: UILabel!
    
    @IBOutlet weak var macLabel: UILabel!
    @IBOutlet weak var ipLabel: UILabel!
    
    @IBOutlet weak var tpNameStack: UIStackView!
    @IBOutlet weak var internetStatusStack: UIStackView!
    @IBOutlet weak var monthFeeStack: UIStackView!
    @IBOutlet weak var dayFeeStack: UIStackView!
    
    @IBOutlet weak var macStack: UIStackView!
    @IBOutlet weak var ipStack: UIStackView!
    
    
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        printInternetPlusInformation()
        
        menu = SideMenuNavigationController(rootViewController: MenuListTableViewController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    @IBAction func didTapMenu(_ sender: Any) {
        present(menu!, animated: true)
        
    }
    
    func printInternetPlusInformation(){
        
        navigationBarInternetPlus.title = "Internet+ " + String(userInternetServicesInfoInternetPlus.uid)
        let cornerRadius = tpNameStack.frame.width/tpNameStack.frame.height
        
        tpNameStack.layer.cornerRadius = cornerRadius
        internetStatusStack.layer.cornerRadius = cornerRadius
        monthFeeStack.layer.cornerRadius = cornerRadius
        dayFeeStack.layer.cornerRadius = cornerRadius
        macStack.layer.cornerRadius = cornerRadius
        ipStack.layer.cornerRadius = cornerRadius
        
        tpNameLabel.text = userInternetServicesInfoInternetPlus.tpName
        
        monthFeeLabel.text = String(userInternetServicesInfoInternetPlus.monthFee)
        dayFeeLabel.text = String(userInternetServicesInfoInternetPlus.dayFee)
        macLabel.text = String(userInternetServicesInfoInternetPlus.cid)
        ipLabel.text = "192.168.1.1"
        
        if userInternetServicesInfoInternetPlus.internetStatus == 0{
            internetStatusStack.backgroundColor = .systemGreen
            internetStasusLabel.text = "Активно"
        }else{
            internetStasusLabel.text = "Не активно"
            internetStatusStack.backgroundColor = .red
        }
    }
}

