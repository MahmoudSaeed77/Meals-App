//
//  HomeViewController.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK:- outelets
    @IBOutlet weak var mealCollectionView: UICollectionView!
    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionHeight: NSLayoutConstraint!
    
    // MARK:- Variables
    var viewModel: HomeViewModel!
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.fetchData()
        
        self.reloadCollections()
    }
    
    // MARK:- UI Functions
    fileprivate func reloadCollections() {
        self.mealCollectionView.reloadData()
        self.typeCollectionView.reloadData()
        self.productsCollectionView.reloadData()
    }
    
    // MARK:- Core Data Functions
    private func fetchData() {
        self.viewModel.userProducts.removeAll()
        self.viewModel.localData.fetchProductsData { products in
            for i in products {
                if Int(i.userId) == UserDefaults.standard.value(forKey: "userId") as! Int {
                    self.viewModel.userProducts.append(i)
                }
            }
        }
        self.viewModel.filteredProducts = self.viewModel.userProducts
    }
    func sordData(selectedMeal: Int, selectedType: Int) {
        
        self.productsCollectionView.reloadData()
        self.fetchData()
        self.viewModel.filteredProducts.removeAll()
        let mealKey: String = self.viewModel.mealData[selectedMeal]
        let typeKey: String = self.viewModel.typeData[selectedType]
        
        print(selectedMeal, selectedType, mealKey, typeKey)
        
        if selectedType == 0 {
            for i in self.viewModel.userProducts {
                if i.meal == mealKey {
                    self.viewModel.filteredProducts.append(i)
                }
            }
            self.productsCollectionView.reloadData()
            return
        }
        
        for i in self.viewModel.userProducts {
            if i.meal == mealKey && i.type == typeKey {
                self.viewModel.filteredProducts.append(i)
            }
        }
        self.productsCollectionView.reloadData()
    }
}
