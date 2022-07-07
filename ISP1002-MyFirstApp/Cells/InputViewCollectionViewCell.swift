//
//  InputViewCollectionViewCell.swift
//  ISP1002-MyFirstApp
//
//  Created by Aman on 07/07/22.
//

import UIKit

class InputViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var inputViewLabel: UILabel!
    
    // MARK: - Cell Initialiser
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setup Cell
    func setupCell(item: InputType) {
        inputViewLabel.text = item.rawValue
    }
    
}
