//
//  MovieListLocalStorage.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation

class MovieListLocalStorage : MovieListLocalStorageProtocol{
    func savePopularMovieList(_ data: [resultsMapperResponse]) {
        LocalStorageManager.shared.savePopularData(data: data)
    }
    
    func saveUpcomingMovieList(_ data: [resultsMapperResponse]) {
        LocalStorageManager.shared.saveUpcomingData(data: data)
    }

    
}
