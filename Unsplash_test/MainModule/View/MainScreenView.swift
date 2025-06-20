//
//  ViewController.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 20.06.2025.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func showPost()
}

class MainScreenView: UIViewController {
    
    var presenter: MainScreenPresenterProtocol!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.dataSource = self
        collection.delegate = self
        collection.register(MainPostCell.self, forCellWithReuseIdentifier: MainPostCell.reuseId)
        collection.alwaysBounceVertical = true
        collection.contentInset.top = 80
        collection.contentInsetAdjustmentBehavior = .scrollableAxes
        
        layout.itemSize = CGSize(width: view.frame.width - 60, height: view.frame.width - 60)
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 40, right: 0)
        
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }


}

extension MainScreenView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.posts?.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPostCell.reuseId, for: indexPath) as? MainPostCell else { return UICollectionViewCell() }
        
        
        
        return cell
    }
    
    
}

extension MainScreenView: MainScreenViewProtocol {
   
    func showPost() {
        collectionView.reloadData()
    }
    
}

