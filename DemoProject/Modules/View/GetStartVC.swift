//
//  GetStartVC.swift
//  DemoProject
//
//  Created by Newmac on 28/06/23.
//

import UIKit

class GetStartVC: UIViewController {
    @IBOutlet weak var btnGetStarted: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        CornerRadiusHelper.applyCornerRadius(10, to: btnGetStarted)
    }
    
    //MARK: Button Action
    @IBAction func btnGetStartedTapped(_ sender: Any) {
        let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherForeCasteVC") as! WeatherForeCasteVC
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
