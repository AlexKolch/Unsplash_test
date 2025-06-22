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
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var presenter: MainScreenPresenterProtocol!
    let deviceSize: CGSize = UIScreen.main.bounds.size
    private lazy var postsCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
        
        let collection = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.layout.invalidateLayout()
        }, completion: nil)
    }
}

extension MainScreenView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: view.frame.width - 60, height: view.frame.width - 90)
        let isPortrait = UIDevice.current.orientation.isPortrait
        if isPortrait {
//            return CGSize(width: view.frame.width - 60, height: view.frame.height / 3)
           return CGSize(width: view.frame.width - 60, height: deviceSize.height * 0.3)
        } else {
//            return CGSize(width: view.frame.width - 60, height: view.frame.width / 3)
            return CGSize(width: view.frame.width - 60, height: deviceSize.height * 0.35)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
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

