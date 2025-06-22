//
//  DetailsView.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 22.06.2025.
//

import UIKit

protocol DetailsViewProtocol: AnyObject { }

final class DetailsView: UIViewController, DetailsViewProtocol {

    @IBOutlet weak var imageView: WebImageManager!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var presenter: DetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = presenter.post.user.username
        imageView.set(imageUrl: presenter.post.urls.regular) {
            self.spinner.stopAnimating()
        }
    }
}
