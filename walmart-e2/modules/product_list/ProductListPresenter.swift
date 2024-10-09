//
//  ProductListPresenter.swift
//  walmart-e2
//
//  Created by Luis Enrique Vazquez Escobar on 08/10/24.
//

import Foundation

class ProductListPresenter: ProductListPresenterProtocol {
    weak var view: ProductListViewProtocol?
    var interactor: ProductListInteractorProtocol?
    var router: ProductListRouterProtocol?
}
