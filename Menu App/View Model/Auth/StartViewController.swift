//
//  StartViewController.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK:- outelets
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    // MARK:- Variables
    var localData = LocaData()
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBarConfiguration()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.choseAction(type: .singup)
    }
    
    // MARK:- UI Functions
    fileprivate func navigationBarConfiguration() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func choseAction(type: AuthAction) {
        switch type {
        case .login:
            self.updateButtonsUI(chosedButton: self.loginBtn)
        case .singup:
            self.updateButtonsUI(chosedButton: self.signupBtn)
        }
    }
    
    fileprivate func updateButtonsUI(chosedButton: UIButton) {
        UIView.transition(with: chosedButton, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            if chosedButton == self.loginBtn {
                self.loginBtn.backgroundColor = UIColor.white
                self.signupBtn.backgroundColor = UIColor.clear
            } else {
                self.signupBtn.backgroundColor = UIColor.white
                self.loginBtn.backgroundColor = UIColor.clear
            }
        }) { _ in
            if chosedButton == self.loginBtn {self.goToLogin()}
        }
        self.view.layoutIfNeeded()
    }
    
    private func goToLogin() {
        let vc = UIStoryboard(name: "Auth", bundle: .main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK:- Actions
    @IBAction func signupAction(_ sender: UIButton) {
        self.choseAction(type: .singup)
    }
    @IBAction func loginAction(_ sender: UIButton) {
        self.choseAction(type: .login)
    }
}
