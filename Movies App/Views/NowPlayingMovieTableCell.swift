//
//  NowPlayingMovieTableCell.swift
//  Movies App
//
//  Created by OmarMansour on 1/27/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NowPlayingMovieTableCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var nowPlayingMovies = PublishSubject<Movies>()
    var movies: Movies?
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .black
        subscribeToMovies()
    }
    
    override func layoutSubviews() {
        configureCollection()
    }
    
    func subscribeToMovies(){
        nowPlayingMovies.subscribe(onNext: {[weak self] (movies) in
            self?.movies = movies
            self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    func configureCollection(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isSpringLoaded = false
                
//        collectionView.isPagingEnabled = true
    }
}

extension NowPlayingMovieTableCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMovieCell", for: indexPath) as! NowPlayingMovieCell
        guard let movies = movies else {return cell}
        guard let url = URL(string: ("https://image.tmdb.org/t/p/w400" + (movies.results[indexPath.row].backdropPath)!)) else {return cell}
        cell.nowPlayingMovieImage.kf.setImage(with: url)
        cell.nowPlayingMovieLabel.text = movies.results[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieId = movies?.results[indexPath.row].id else {return}
        HomeViewController.selectedMovieId.accept(movieId)
    }
    
}
