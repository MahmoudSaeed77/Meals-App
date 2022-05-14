//
//  HomeViewModel.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import Foundation

class HomeViewModel {
    private weak var view: HomeViewController!
    
    var localData = LocaData()
    var userProducts = [Products]()
    var filteredProducts = [Products]()
    var mealData = ["Breakfast", "Dinner", "Desserts", "Lunch", "Drinks"]
    var typeData = ["All", "Plates", "Hot Drinks", "Iced Coffee"]
    
    var selectedMeal: Int = 0
    var selectedType: Int = 0
    
    
    init(view: HomeViewController) {
        self.view = view
    }
}
