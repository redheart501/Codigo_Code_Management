//
//  MovieListPresenter.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit

class MovieListPresenter : MovieListPresenterProtocol {
    
    
   
    
    weak var view: MovieListViewProtocol?
    var router: MovieListRouterProtocol?
    var interactor: MovieListInteractorInputProtocol?
    
    func getMovieList(_ type: String) {
        interactor?.callMovieListApi(type)
    }
 
    func presentToDetailView(_ data: resultsMapperResponse) {
        router?.presentToDetailView(data, view: view!)
    }
    
}
extension MovieListPresenter:  MovieListInteractorOutputProtocol{
    func success(_ data: [resultsMapperResponse], type: String) {
        if type == "upcoming"{
            view?.showUpcomingMovieList(data)
        }else{
            view?.showPopularMovieList(data)
        }
        
    }
    

    func fail() {
       
    }
    
    
}
