//
//  AllMoviesViewController.swift
//  Movies App
//
//  Created by OmarMansour on 2/1/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AllMoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let allMoviesVM = AllMoviesViewModel()
    let disposeBag = DisposeBag()
    var movies: Movies? = nil
    var moviesType = 0
    var selectedMovieId: Int?
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        getMovies(page: page)
        subscribeToMovies()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func getMovies(page: Int){
        switch moviesType{
        case 1:
            allMoviesVM.getNowPlayingMovies(page: page)
        case 2:
            allMoviesVM.getTopRatedMovies(page: page)
        case 3:
            allMoviesVM.getPopularMovies(page: page)
        default:
            return
        }
    }
    
    func subscribeToMovies(){
        allMoviesVM.nowPlayingMovies.subscribe(onNext: {[weak self] movies in
            if(self?.page == 1){
                self?.movies = movies
            }
            else{
              self?.movies?.results.append(contentsOf: movies.results)
            }
            self?.navigationItem.title = "Now Playing"
            self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
        allMoviesVM.topRatedMovies.subscribe(onNext: {[weak self] movies in
            if(self?.page == 1){
                self?.movies = movies
            }
            else{
                self?.movies?.results.append(contentsOf: movies.results)
            }
            self?.navigationItem.title = "Top Rated"
            self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
        allMoviesVM.popularMovies.subscribe(onNext: {[weak self] movies in
            if(self?.page == 1){
                self?.movies = movies
            }
            else{
                self?.movies?.results.append(contentsOf: movies.results)
            }
            self?.navigationItem.title = "Popular"
            self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    func configureCollection(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width * 0.3, height: view.frame.height/2.5)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}


extension AllMoviesViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let moviesCount = movies?.results.count else {return 0}
        return moviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllNowPlayingMovieCell", for: indexPath) as! AllNowPlayingMovieCell        
        guard let movies = self.movies?.results else {return cell}
        guard let image = movies[indexPath.row].posterPath else {return cell}
        guard let url = URL(string: ("https://image.tmdb.org/t/p/w400" + image)) else {return cell}
        cell.allNowPlayingMovieImage.kf.setImage(with: url)
        cell.movieTitle.text = movies[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.3, height: view.frame.height/2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMovieId = movies?.results[indexPath.row].id
        performSegue(withIdentifier: "ToMovieDetailsFromAll", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let movies = self.movies else {return}
        if(indexPath.row == movies.results.count - 1){
            self.page += 1
            self.getMovies(page: self.page)
        }
    }
    
}

extension AllMoviesViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MovieDetailsViewController
        destination.movieId = selectedMovieId
    }
}
