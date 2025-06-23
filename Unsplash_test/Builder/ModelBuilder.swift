//
//  Builder.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 20.06.2025.
//

import UIKit

protocol Builder {
    static func createMainScreen() -> UIViewController
    static func createDetailsScreen(post: PostData) -> UIViewController
}

final class ModelBuilder: Builder {
    static func createMainScreen() -> UIViewController {
        let view = MainScreenView()
        let presenter = MainScreenPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createDetailsScreen(post: PostData) -> UIViewController {
        let detailsView = DetailsView()
        let detailsPresenter = DetailsPresenter(view: detailsView, post: post)
        detailsView.presenter = detailsPresenter
        return detailsView
    }
}
