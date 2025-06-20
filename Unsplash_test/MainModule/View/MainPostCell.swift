//
//  MainPostCell.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 20.06.2025.
//

import UIKit

class MainPostCell: UICollectionViewCell {
    static let reuseId = "MainPostCell"
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
