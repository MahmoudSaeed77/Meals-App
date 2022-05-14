//
//  SearchCell.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

class SearchCell: UICollectionViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configCellUI(selected: Bool) {
        if selected {
            self.nameLbl.textColor = UIColor.white
            self.contentView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.4196078431, blue: 0.4078431373, alpha: 1)
        } else {
            self.nameLbl.textColor = UIColor.black
            self.contentView.backgroundColor = UIColor.white
        }
    }
}
