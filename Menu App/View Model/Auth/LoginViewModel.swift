//
//  LoginViewModel.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import Foundation

class LoginViewModel {
    private weak var view: LoginViewController!
    
    var localData = LocaData()
    init(view: LoginViewController) {
        self.view = view
    }
}
