//
//  ViewController.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 20.06.2025.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func showPost()
    func showAlert(messageError: String)
}

final class MainScreenView: UIViewController {
    
    var presenter: MainScreenPresenterProtocol!
    
    private lazy var postsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 60, height: view.frame.width - 90)
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collection = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white

        let nib = UINib(nibName: "PostCVCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: PostCVCell.reuseId)
        collection.contentInsetAdjustmentBehavior = .scrollableAxes

        return collection
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Unsplash posts"
        view.addSubview(postsCollectionView)
    }

}

extension MainScreenView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCVCell.reuseId, for: indexPath) as? PostCVCell else { return UICollectionViewCell() }

        if let post = presenter.posts?[indexPath.item] {
            cell.configureCell(item: post)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let post = presenter.posts?[indexPath.item] else { return }
        let detailsVC = ModelBuilder.createDetailsScreen(post: post)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension MainScreenView: MainScreenViewProtocol {
   
    func showPost() {
        postsCollectionView.reloadData()
    }
    
    func showAlert(messageError: String) {
        let alert = UIAlertController(title: messageError, message: "Please, repeat later again", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.presenter.getPosts()
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }

}

