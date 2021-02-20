//
//  ViewController.swift
//  Movies App
//
//  Created by OmarMansour on 1/20/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let homeVM = HomeViewModel()
    let disposeBag = DisposeBag()
    var nowPlayingMovies: Movies?
    var popularMovies: Movies?
    var topRatedMovies: Movies?
    var categoryTitle = ["Now Playing", "Top Rated", "Popular"]
    var seeAllIndex = 0
    static var selectedMovieId = BehaviorRelay<Int>(value: 0)
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuretableView()
        getMovies(page: page)
        subscribeToMovies()
        subscribeToMovieId()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func getMovies(page: Int){
        homeVM.getNowPlayingMovies(page: page)
        homeVM.getPopularMovies(page: page)
        homeVM.getTopRatedMovies(page: page)
    }
    
    func subscribeToMovies(){
        homeVM.nowPlayingMovies.subscribe(onNext: {[weak self] movies in
            self?.nowPlayingMovies = movies
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        homeVM.popularMovies.subscribe(onNext: {[weak self] movies in
            self?.popularMovies = movies
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        homeVM.topRatedMovies.subscribe(onNext: {[weak self] movies in
            self?.topRatedMovies = movies
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func subscribeToMovieId(){
        HomeViewController.selectedMovieId.subscribe(onNext: {[weak self] id in
            if id != 0{
                self?.performSegue(withIdentifier: "ToMovieDetailsFromHome", sender: self)
            }
        }).disposed(by: disposeBag)
    }
    
    func configuretableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.reloadData()
    }
    
    @objc func seeAllPressed(_ sender: UIButton){
        
        switch sender.tag{
        case 0:
            seeAllIndex = 1
        case 1:
            seeAllIndex = 2
        case 2:
            seeAllIndex = 3
        default:
            seeAllIndex = 0
        }
        performSegue(withIdentifier: "ToAllMovies", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "ToAllMovies":
            let destinationVC = segue.destination as! AllMoviesViewController
            destinationVC.moviesType = seeAllIndex
        case "ToMovieDetailsFromHome":
            let destinationVC = segue.destination as! MovieDetailsViewController
            destinationVC.movieId = HomeViewController.selectedMovieId.value
        default:
            return
        }
        
    }
    
}

extension HomeViewController: UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NowPlayingMovieTableCell") as! NowPlayingMovieTableCell
            guard let movies = nowPlayingMovies else {return cell}
            cell.nowPlayingMovies.onNext(movies)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllNowPlayingMovieTableCell") as! AllNowPlayingMovieTableCell
            switch indexPath.row{
            case 0:
                cell.movies = nowPlayingMovies
            case 1:
                cell.movies = topRatedMovies
            default:
                cell.movies = popularMovies
            }
            cell.sectionTitle.text = categoryTitle[indexPath.row]
            cell.seeAllButton.tag = indexPath.row
            cell.seeAllButton.addTarget(self, action: #selector(seeAllPressed), for: .touchUpInside)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return view.frame.height/2.5
        case 1:
            return view.frame.height/3
        default:
            return 0
        }
    }
}
