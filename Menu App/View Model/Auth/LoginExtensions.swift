//
//  LoginExtensions.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

extension LoginViewController:  UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if isValid() {
            loginBtnUI(valid: true)
        } else {
            loginBtnUI(valid: false)
        }
        return true;
    }
}


extension LoginViewController:  GoToHomeDelegate {
    func instatiateHomeViewController() {
        self.goToHome()
    }
}
