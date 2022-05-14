//
//  ProductCell.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCellUI(data: Products) {
        self.productImgView.image = UIImage(data: data.image ?? Data())
        self.nameLbl.text = data.name ?? ""
        self.priceLbl.text = data.price ?? ""
    }
}
