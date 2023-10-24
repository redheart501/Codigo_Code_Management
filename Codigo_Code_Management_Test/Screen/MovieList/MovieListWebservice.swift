//
//  MovieListWebservice.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class MovieListWebService : MovieListWebServiceInputProtocol{
    var interactor: MovieListWebServiceOutputProtocol?
    
    func callMovieList(listType_ listType : String){
        let url = Constants.baseUrl + listType + "?api_key=" + Constants.apikey
        let req = AF.request(url, method: .get,encoding: JSONEncoding.default).responseJSON { (responce) in
            switch responce.result {
            case .success(let value):
                
                if let json = value as? [String: Any],
                   let data = Mapper<MovieListModel>().map(JSON: json) {
                    
                    self.interactor?.responseMovieList(true, data: data.results ?? [],type: listType)
                } else {
                    print("Mapping error")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        print(req.cURLDescription())
    }
}

