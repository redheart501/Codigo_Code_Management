//
//  DatabaseManager.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import RealmSwift


class PopularMovieObject: Object {
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var original_title: String?
    @Persisted var overview: String?
    @Persisted var popularity: String?
    @Persisted var poster_path : String?
    @Persisted var isFav : Bool?

}
class UpcomingMovieObject: Object {
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var original_title: String?
    @Persisted var overview: String?
    @Persisted var popularity: String?
    @Persisted var poster_path : String?
    @Persisted var isFav : Bool?

}
class LocalStorageManager {
    
    static let shared = LocalStorageManager()
    private init() {}
    
    private let realm = try! Realm()
    
    func savePopularData(data: [resultsMapperResponse]) {
        
        try! realm.write{
            
            for i in data{
                let movieObject = PopularMovieObject()
                movieObject.id = i.id
                movieObject.original_title = i.original_title
                movieObject.overview = i.overview
                movieObject.popularity = i.popularity
                movieObject.poster_path = i.poster_path
                movieObject.isFav = i.isFav
                if realm.object(ofType: PopularMovieObject.self, forPrimaryKey: movieObject.id) == nil {
                    realm.add(movieObject)
                }
            }
          
            
        }
    }
    func saveUpcomingData(data: [resultsMapperResponse]) {
        
        try! realm.write{
            
            for i in data{
                let movieObject = UpcomingMovieObject()
                movieObject.id = i.id
                movieObject.original_title = i.original_title
                movieObject.overview = i.overview
                movieObject.popularity = i.popularity
                movieObject.poster_path = i.poster_path
                movieObject.isFav = i.isFav
                if realm.object(ofType: UpcomingMovieObject.self, forPrimaryKey: movieObject.id) == nil {
                    realm.add(movieObject)
                }
            }
          
            
        }
    }
    
    func retrieveUpcomingData() -> [resultsMapperResponse] {
        let realm = try! Realm()
        let movieObjects = realm.objects(UpcomingMovieObject.self)
        var results: [resultsMapperResponse] = []

        for movieObject in movieObjects {
            let result = resultsMapperResponse(
                id: movieObject.id,
                original_title: movieObject.original_title,
                overview: movieObject.overview,
                popularity: movieObject.popularity,
                poster_path: movieObject.poster_path,
                isFav: movieObject.isFav
            )
            results.append(result)
        }

        return results
    }
    
    func retrievePopularData() -> [resultsMapperResponse] {
        let realm = try! Realm()
        let movieObjects = realm.objects(PopularMovieObject.self)
        var results: [resultsMapperResponse] = []

        for movieObject in movieObjects {
            let result = resultsMapperResponse(
                id: movieObject.id,
                original_title: movieObject.original_title,
                overview: movieObject.overview,
                popularity: movieObject.popularity,
                poster_path: movieObject.poster_path,
                isFav: movieObject.isFav
            )
            results.append(result)
        }

        return results
    }
    
    func setFav(data: resultsMapperResponse){
        try! realm.write{
            
            if let update = realm.object(ofType: UpcomingMovieObject.self, forPrimaryKey: data.id) {
                update.isFav = data.isFav
                realm.add(update, update: .modified)
            }
            if let update = realm.object(ofType: PopularMovieObject.self, forPrimaryKey: data.id) {
                update.isFav = data.isFav
                realm.add(update, update: .modified)
            }
          
            
        }
    }
    
}
