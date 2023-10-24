//
//  MoviewListProtocol.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit

protocol MovieListViewProtocol: AnyObject {
    var presenter: MovieListPresenterProtocol? { get set }
    func showUpcomingMovieList(_ data : [resultsMapperResponse])
    func showPopularMovieList(_ data : [resultsMapperResponse])
}

protocol MovieListPresenterProtocol: AnyObject {
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorInputProtocol? { get set }
    var router: MovieListRouterProtocol? { get set }
    func getMovieList(_ type : String)
    func presentToDetailView(_ data : resultsMapperResponse)
 
}

protocol MovieListInteractorInputProtocol {
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var webService: MovieListWebServiceInputProtocol? { get set }
    var localStorage: MovieListLocalStorageProtocol? { get set }
    func callMovieListApi(_ type : String)
}

protocol MovieListInteractorOutputProtocol: AnyObject {
    func success(_ data : [resultsMapperResponse],type : String)
    func fail()
}

protocol MovieListWebServiceInputProtocol {
    var interactor: MovieListWebServiceOutputProtocol? { get set }
    func callMovieList(listType_ : String)
    
}
protocol MovieListWebServiceOutputProtocol {
    func responseMovieList(_ isSuccess : Bool? , data : [resultsMapperResponse],type : String)
}

protocol MovieListLocalStorageProtocol{
    func savePopularMovieList(_ data : [resultsMapperResponse])
    func saveUpcomingMovieList(_ data : [resultsMapperResponse])
}

protocol MovieListRouterProtocol: AnyObject {
    static func createModule() -> UIViewController?
    func presentToDetailView(_ data : resultsMapperResponse,view:MovieListViewProtocol)
}
