//
//  MoviewListModel.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import ObjectMapper

class MovieListModel : Mappable {
    
    var results : [resultsMapperResponse]?
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        results <- map["results"]
    }
        
}

class resultsMapperResponse : Mappable {
    
    var original_title: String?
    var overview: String?
    var popularity: String?
    var id : Int?
    var poster_path : String?
    var isFav : Bool? = false
    
    required init?(map: Map) {
        
    }
    init(id: Int!, original_title: String!, overview: String!, popularity: String!, poster_path: String!, isFav: Bool!) {
        self.id = id
        self.original_title = original_title
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.isFav = isFav
    }
    
    func mapping(map: Map) {
        
        original_title <- map["original_title"]
        id <- map["id"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
    }
    
}

