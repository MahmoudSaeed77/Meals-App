//
//  LoginViewController.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK:- outelets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinBtn: AppButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet var fields: [UITextField]!
    
    // MARK:- Variables
    private var viewModel: LoginViewModel!
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LoginViewModel(view: self)
        self.UI()
        self.handleKeyboard()
        self.configureRegisterBtnUI()
        self.loginBtnUI(valid: false)
        self.fieldsDelegateConfiguration()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK:- UI Functions
    fileprivate func UI() {
        self.hideKeyboardWhenTappedAround()
        self.signinBtn.dropShadow()
    }
    private func fieldsDelegateConfiguration() {
        fields.forEach({ field in
            field.delegate = self
        })
    }
    
    fileprivate func configureRegisterBtnUI() {
        let regular = NSAttributedString(string: "Not a member? ")
        let attrString = "Register now"
        let bold = NSAttributedString(string: attrString, attributes: [.font : UIFont.boldSystemFont(ofSize: 20)])
        let result = NSMutableAttributedString()
        result.append(regular)
        result.append(bold)
        self.registerBtn.setAttributedTitle(result, for: .normal)
    }
    
    func loginBtnUI(valid: Bool) {
        switch valid {
        case true:
            signinBtn.isEnabled = true
            signinBtn.alpha = 1
        case false:
            signinBtn.isEnabled = false
            signinBtn.alpha = 0.1
        }
    }
    
    func isValid() -> Bool {
        var value: Bool?
        self.fields.forEach({field in
            if (field.text?.count ?? 0) > 2 {
                value = true
            } else {
                value = false
            }
        })
        return value ?? false
    }
    
    func goToHome() {
        let vc = UIStoryboard(name: "Tab", bundle: .main).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    private func goToAdd() {
        let vc = UIStoryboard(name: "Tab", bundle: .main).instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func saveUserId(userId: Int) {
        print("id is here", userId)
        UserDefaults.standard.set(userId, forKey: "userId")
        UserDefaults.standard.synchronize()
    }
    
    private func checkIfUserHadProducts(userId: Int) {
        self.viewModel.localData.fetchProductsData { products in
            for i in products {
                if userId == Int(i.userId) {
                    self.goToHome()
                    return
                }
            }
            self.goToAdd()
        }
    }
    private func saveUserData(userId: Int) {
        self.saveUserId(userId: userId)
        self.checkIfUserHadProducts(userId: userId)
    }
    
    fileprivate func handleKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // MARK:- Actions
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @IBAction func recoveryPassAction(_ sender: UIButton) {
        self.alert(success: false, withImage: true, message: "Recovery password still in development phase, Sorry!") {}
    }
    @IBAction func signinAction(_ sender: UIButton) {
        self.signinBtn.indicator.startAnimating()
        self.viewModel.localData.fetchUserData { users in
            for i in users {
                if usernameField.text == i.username && passwordField.text == i.password {
                    // user already exists so we logeed in
                    self.saveUserData(userId: Int(i.id))
                    return
                }
            }
            // user not found so we create a new user
            let userId = Int(arc4random())
            self.viewModel.localData.saveUserData(id: userId, username: self.usernameField.text ?? "", password: self.passwordField.text ?? "") { _ in
                print("user added successfully")
                self.alert(success: true, withImage: true, message: "user created successfully") {
                    self.saveUserData(userId: userId)
                }
            }
        }
        self.signinBtn.indicator.stopAnimating()
    }
    @IBAction func registerAction(_ sender: UIButton) {
        self.alert(success: false, withImage: true, message: "Currently if you logged in with non exist user we will register a new one!"){}
    }
    
}
