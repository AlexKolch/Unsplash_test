//
//  DetailsPresenter.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 22.06.2025.
//

import UIKit

protocol DetailsPresenterProtocol: AnyObject {
    init(view: DetailsViewProtocol, post: PostData)
    var post: PostData {get}
}

final class DetailsPresenter: DetailsPresenterProtocol {
    private weak var view: DetailsViewProtocol?
    let post: PostData
    
    init(view: DetailsViewProtocol, post: PostData) {
        self.view = view
        self.post = post
    }
}
