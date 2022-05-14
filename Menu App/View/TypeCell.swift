//
//  TypeCell.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

class TypeCell: UICollectionViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configCellUI(selected: Bool) {
        if selected {
            self.nameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)
        } else {
            self.nameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.34)
        }
    }
}
