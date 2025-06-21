//
//  PostCVCell.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 21.06.2025.
//

import UIKit

class PostCVCell: UICollectionViewCell {
    static let reuseId = "PostCVCell"
    @IBOutlet weak var imagePost: WebImageManager! 
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
         layer.cornerRadius = 10
         layer.masksToBounds = true
        imagePost.contentMode = .scaleAspectFill
     }
    
    func configureCell(item: PostData) {
        spinner.startAnimating()
        imagePost.set(imageUrl: item.urls.thumb) { [weak self] in
            self?.spinner.stopAnimating()
        }
        
        likesLabel.text = "Like: \(item.likes)"
        descriptionLabel.text = item.description ?? item.altDescription ?? ""
        descriptionLabel.textColor = UIColor(item.color)
       
    }
}
