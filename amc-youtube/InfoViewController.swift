//
//  InfoViewController.swift
//  amc-youtube
//
//  Created by thisdjango on 10.03.2020.
//  Copyright © 2020 thisdjango. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var imageLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.traitCollection.userInterfaceStyle == .dark{
            imageLogo.image = UIImage(named: "logow.png")
        }
    }
    
    
    @IBAction func showDetails(_ sender: UIButton) {
        
        var url = URL(string: "")
        if(sender.titleLabel?.text == "Учись"){
            url = URL(string: "https://amc.ru/learn/")
        }else if(sender.titleLabel?.text == "Общайся"){
            url = URL(string: "https://amc.ru/connect/")
        }else if(sender.titleLabel?.text == "Создавай"){
            url = URL(string: "https://amc.ru/produce/")
        }
        
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    @IBAction func callAction(_ sender: UIButton) {
        let url = URL(string: "tel://\(sender.titleLabel!.text!)")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    @IBAction func showSite(_ sender: UIButton) {
        let url = URL(string: sender.titleLabel!.text!)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
