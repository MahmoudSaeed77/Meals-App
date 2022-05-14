//
//  HomeExtensions.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case mealCollectionView:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case typeCollectionView:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case productsCollectionView:
            return CGSize(width: (collectionView.frame.width / 2) - 20, height: 245)
        default:
            return CGSize()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case mealCollectionView:
            print(indexPath)
            self.viewModel.selectedMeal = indexPath.item
            self.mealCollectionView.reloadData()
            self.sordData(selectedMeal: self.viewModel.selectedMeal, selectedType: self.viewModel.selectedType)
        case typeCollectionView:
            print(indexPath)
            self.viewModel.selectedType = indexPath.item
            self.typeCollectionView.reloadData()
            self.sordData(selectedMeal: self.viewModel.selectedMeal, selectedType: self.viewModel.selectedType)
        case productsCollectionView:
            print(indexPath)
        default:
            break
        }
    }
}
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mealCollectionView:
            return self.viewModel.mealData.count
        case typeCollectionView:
            return self.viewModel.typeData.count
        case productsCollectionView:
            let count = self.viewModel.filteredProducts.count
            self.productsCollectionHeight.constant = CGFloat(count * 245)
            return count
        default:
            return Int()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mealCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
            cell.nameLbl.text = self.viewModel.mealData[indexPath.item]
            if self.viewModel.selectedMeal == indexPath.item {
                cell.configCellUI(selected: true)
            } else {
                cell.configCellUI(selected: false)
            }
            return cell
        case typeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCell", for: indexPath) as! TypeCell
            cell.nameLbl.text = self.viewModel.typeData[indexPath.item]
            if self.viewModel.selectedType == indexPath.item {
                cell.configCellUI(selected: true)
            } else {
                cell.configCellUI(selected: false)
            }
            return cell
        case productsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            cell.configCellUI(data: self.viewModel.filteredProducts[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
