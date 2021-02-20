//
//  MovieDetailsViewController.swift
//  Movies App
//
//  Created by OmarMansour on 2/3/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    var movieId: Int?
    let movieDetailsVM = MovieDetailsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovieDetails()
        subscribeToMovie()
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
    
    func getMovieDetails(){
        guard let movieId = movieId else {return}
        movieDetailsVM.getMovieDetails(movieId: movieId)
    }
    
    func subscribeToMovie(){
        movieDetailsVM.movie.subscribe(onNext: {[weak self] movie in
            if let image = movie.backdropPath{
                let url = URL(string:"https://image.tmdb.org/t/p/w400" + image)
                self?.movieImage.kf.setImage(with: url)
            }
            self?.movieTitle.text = movie.title
            self?.movieDescription.text = movie.overview
            }).disposed(by: disposeBag)
    }
    
}
