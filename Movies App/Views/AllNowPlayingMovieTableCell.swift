//
//  AllNowPlayingMovieTableCell.swift
//  Movies App
//
//  Created by OmarMansour on 1/29/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AllNowPlayingMovieTableCell: UITableViewCell {
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var allNowPlayingMovieCollection: UICollectionView!
    @IBOutlet weak var seeAllButton: UIButton!
    var movies: Movies?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        configureCollection()
    }
    
    func configureCollection(){
        
        allNowPlayingMovieCollection.delegate = self
        allNowPlayingMovieCollection.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: frame.width/3, height: allNowPlayingMovieCollection.frame.height)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        self.allNowPlayingMovieCollection.reloadData()
        
        allNowPlayingMovieCollection.collectionViewLayout = layout
    }

}

extension AllNowPlayingMovieTableCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllNowPlayingMovieCell", for: indexPath) as! AllNowPlayingMovieCell
        
        let url = URL(string: ("https://image.tmdb.org/t/p/w400" + (movies?.results[indexPath.row].posterPath)!))
        cell.allNowPlayingMovieImage.kf.setImage(with: url)
        cell.movieTitle.text = movies?.results[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieId = movies?.results[indexPath.row].id else {return}
        HomeViewController.selectedMovieId.accept(movieId)
    }
}
