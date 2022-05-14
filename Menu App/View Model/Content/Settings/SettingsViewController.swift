//
//  SettingsViewController.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK:- outelets
    @IBOutlet weak var logoutBtn: AppButton!
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.UI()
    }
    // MARK:- UI Functions
    fileprivate func UI() {
        self.logoutBtn.dropShadow()
        self.navigationController?.navigationBar.isHidden = true
    }
    // MARK:- Actions
    @IBAction func logoutAction(_ sender: UIButton) {
        self.logoutBtn.indicator.startAnimating()
        UserDefaults.standard.setValue(nil, forKey: "userId")
        let vc = UIStoryboard(name: "Auth", bundle: .main).instantiateViewController(withIdentifier: "authNav") as! UINavigationController
        let Delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        Delegate.window?.layoutIfNeeded()
        Delegate.window?.rootViewController = vc
        UIView.transition(with: Delegate.window!, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        self.logoutBtn.indicator.stopAnimating()
    }
}
