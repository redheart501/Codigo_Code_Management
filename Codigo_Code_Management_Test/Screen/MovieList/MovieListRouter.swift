//
//  MoviewListRouter.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit


class MovieListRouter : MovieListRouterProtocol {
    
    static func createModule() -> UIViewController? {
        guard let view = UIViewController.MovieListViewController as? MovieListViewController else { return nil }
        let router: MovieListRouterProtocol = MovieListRouter()
        var presenter: MovieListPresenterProtocol & MovieListInteractorOutputProtocol = MovieListPresenter()
        var interactor: MovieListInteractorInputProtocol & MovieListWebServiceOutputProtocol = MovieListViewInteractor()
        var webService: MovieListWebServiceInputProtocol = MovieListWebService()
        let localStorage: MovieListLocalStorageProtocol = MovieListLocalStorage()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.webService = webService
        interactor.localStorage = localStorage
        webService.interactor = interactor
        return view
    }
    
    func presentToDetailView(_ data: resultsMapperResponse,view: MovieListViewProtocol) {
        guard let view = view as? UIViewController else { return }
       
        if let  vc = MovieDetailRouter.createModule(data){
            view.present(vc, animated: true)
        }
    }
    }
