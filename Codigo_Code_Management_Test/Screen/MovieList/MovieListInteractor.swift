//
//  MovieListInteractor.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit

class MovieListViewInteractor: MovieListInteractorInputProtocol {
    
    
    var presenter: MovieListInteractorOutputProtocol?
    var localStorage : MovieListLocalStorageProtocol?
    var webService: MovieListWebServiceInputProtocol?
    
    func callMovieListApi(_ type: String) {
        webService?.callMovieList(listType_: type)
    }
    
    
}

extension MovieListViewInteractor : MovieListWebServiceOutputProtocol{
    func responseMovieList(_ isSuccess: Bool?, data: [resultsMapperResponse],type:String) {
        if isSuccess!{
            presenter?.success(data,type:type )
            if type == "upcoming"{
                localStorage?.saveUpcomingMovieList(data)
            }else{
                localStorage?.savePopularMovieList(data)
            }
            
            
        }else{
            presenter?.fail()
        }
    }
    

    
    
    
}
