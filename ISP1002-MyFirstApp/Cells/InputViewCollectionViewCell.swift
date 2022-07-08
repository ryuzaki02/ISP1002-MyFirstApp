//
//  InputViewCollectionViewCell.swift
//  ISP1002-MyFirstApp
//
//  Created by Aman on 07/07/22.
//

import UIKit

class InputViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var inputViewLabel: UILabel!
    @IBOutlet var parentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setup Cell
    func setupCell(item: InputType) {
        layer.cornerRadius = bounds.size.height / 2
        backgroundColor = item.buttonType == .number ? UIColor.lightGray : UIColor.orange
        inputViewLabel.text = item.rawValue
    }
    
}
