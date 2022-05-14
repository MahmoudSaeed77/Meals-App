//
//  AddProductViewModel.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

class AddProductViewModel {
    private weak var view: AddProductViewController!
    
    var localData = LocaData()
    var mealData = ["Breakfast", "Dinner", "Desserts", "Lunch", "Drinks"]
    var typeData = ["Plates", "Hot Drinks", "Iced Coffee"]
    var isMealSelected: Bool?
    
    init(view: AddProductViewController) {
        self.view = view
    }
}
