//
//  MovieListViewController.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit
import AlamofireImage
import RxSwift
import RealmSwift



class MovieListViewController : UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var presenter : MovieListPresenterProtocol?
    private var upcomingMovieLists = [resultsMapperResponse](){didSet{self.tableView.reloadData()}}
    private var popularMovieLists = [resultsMapperResponse](){didSet{self.collectionView.reloadData()}}
    var tasks: Results<UpcomingMovieObject>!
    var tasks2: Results<PopularMovieObject>!
    var notificationToken: NotificationToken?
    var notificationToken1: NotificationToken?
    override func viewDidLoad() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.popularMovieLists = LocalStorageManager.shared.retrievePopularData()
        self.upcomingMovieLists = LocalStorageManager.shared.retrieveUpcomingData()
        getData()
        
        let realm = try! Realm()
        tasks = realm.objects(UpcomingMovieObject.self)
        tasks2 = realm.objects(PopularMovieObject.self)
        notificationToken = tasks.observe { [weak self] changes in
                    guard let tableView = self?.tableView else { return }
                    
                    switch changes {
                    case .initial:
                        // Initial data load, do nothing
                        tableView.reloadData()
                        
                    case .update(_, let deletions, let insertions, let modifications):
                        // Handle updates, insertions, and deletions
                        tableView.reloadData()
                        
                    case .error(let error):
                        // Handle any errors
                        print("Error: \(error)")
                    }
                }
        notificationToken1 = tasks2.observe { [weak self] changes in
                    guard let collectionView = self?.collectionView else { return }
                    
                    switch changes {
                    case .initial:
                        // Initial data load, do nothing
                        collectionView.reloadData()
                        
                    case .update(_, let deletions, let insertions, let modifications):
                        // Handle updates, insertions, and deletions
                        collectionView.reloadData()
                        
                    case .error(let error):
                        // Handle any errors
                        print("Error: \(error)")
                    }
                }
    
    }
    func getData(){
        presenter?.getMovieList("upcoming")
        presenter?.getMovieList("popular")
        
    }
}
extension MovieListViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.popularMovieLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCollectionCell", for: indexPath) as? popularCollectionCell else {
            return UICollectionViewCell()
        }
        
        let obj = self.popularMovieLists[indexPath.row]
        cell.lblMovieTitle.text = obj.original_title
        if let urlimage = URL(string: "https://image.tmdb.org/t/p/w500/" + (obj.poster_path)!) {
            cell.imgView.af_setImage(withURL: urlimage)
        }
        cell.btnFav.setBackgroundImage(UIImage(systemName: obj.isFav ?? false ? "heart.fill": "heart"), for: .normal)
        cell.buttonAction = {
            obj.isFav?.toggle()
            LocalStorageManager.shared.setFav(data: obj)
        }
        return cell
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.popularMovieLists[indexPath.row]
        self.presenter?.presentToDetailView(obj)
    }
    
    
}
extension MovieListViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingMovieLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingTableCell", for: indexPath) as? upcomingTableCell else {
            return UITableViewCell()
        }
        let obj = self.upcomingMovieLists[indexPath.row]
        cell.lblMovieTitle.text = obj.original_title
        if let urlimage = URL(string: "https://image.tmdb.org/t/p/w500/" + (obj.poster_path)!) {
            cell.imgView.af_setImage(withURL: urlimage)
        }
        cell.btnFav.setBackgroundImage(UIImage(systemName: obj.isFav ?? false ? "heart.fill": "heart"), for: .normal)
        cell.buttonAction = {
            obj.isFav?.toggle()
            cell.btnFav.setBackgroundImage(UIImage(systemName: obj.isFav ?? false ? "heart.fill": "heart"), for: .normal)
            LocalStorageManager.shared.setFav(data: obj)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.upcomingMovieLists[indexPath.row]
        self.presenter?.presentToDetailView(obj)
    }
}

extension MovieListViewController  : MovieListViewProtocol {
    func showUpcomingMovieList(_ data: [resultsMapperResponse]) {
        self.upcomingMovieLists = data
    }
    
    func showPopularMovieList(_ data: [resultsMapperResponse]) {
        self.popularMovieLists = data
    }
    
    
    
    
}
