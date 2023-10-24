//
//  MovieDetailViewController.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit
import AlamofireImage


class MovieDetailViewController : UIViewController{
    
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var overViewTextView : UITextView!
    var data : resultsMapperResponse?
    var isFav = false
    override func viewDidLoad() {
        initial()
        
    }
    
    private func initial(){
        lblMovieTitle.text = data?.original_title
        overViewTextView.text =  data?.overview
        if let urlimage = URL(string: "https://image.tmdb.org/t/p/w500/" + (data?.poster_path)!) {
            imgView.af_setImage(withURL: urlimage)
        }
        self.btnFav.setBackgroundImage(UIImage(systemName: (data?.isFav ?? false) ? "heart.fill": "heart"), for: .normal)
        isFav = data?.isFav ?? false
    }
    
    @IBAction func clickFav(_ sender: Any) {
        isFav.toggle()
        self.btnFav.setBackgroundImage(UIImage(systemName: isFav ? "heart.fill": "heart"), for: .normal)
        data?.isFav = isFav
        print(data)
        LocalStorageManager.shared.setFav(data: data!)
    }
   
}
