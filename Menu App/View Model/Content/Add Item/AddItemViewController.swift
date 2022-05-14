//
//  AddItemViewController.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

class AddItemViewController: UIViewController {
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToAddController()
    }
    
    fileprivate func goToAddController() {
        let vc = UIStoryboard(name: "Tab", bundle: .main).instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController
        vc.type = .fromHome
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

}
