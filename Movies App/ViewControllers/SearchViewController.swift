//
//  SearchViewController.swift
//  Movies App
//
//  Created by OmarMansour on 2/18/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let searchVM = SearchViewModel()
    let disposeBag = DisposeBag()
    var page = "1"
    var movies: Movies?
    var selectedMovieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        searchBar.delegate = self
        subscribeToMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
    }
    
    func configureTableView(){
        tableView.isHidden = true
        tableView.tableFooterView = UIView()
    }
    
    func getMovies(page: String){
        searchVM.getMovies(page: page)
    }
    
    func subscribeToMovies(){
        searchVM.movies.subscribe(onNext: {[weak self] movies in
            self?.movies = movies
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
            }).disposed(by: disposeBag)
    }
    
    
}

extension SearchViewController: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let moviesCount = movies?.results.count else {return 0}
        return moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieCell", for: indexPath) as! SearchMovieCell
        guard let movies = self.movies?.results else {return cell}
        if let image = movies[indexPath.row].posterPath{
            guard let url = URL(string: ("https://image.tmdb.org/t/p/w400" + image)) else {return cell}
            cell.movieImage.kf.setImage(with: url)
        }
        cell.movieName.text = movies[indexPath.row].title
        cell.movieStarRating.rating = movies[indexPath.row].voteAverage!/2.0
        cell.movieRating.text = "\(movies[indexPath.row].voteAverage ?? 0.0)" + "/10"
        let date = HelperFunctions.convertDateFormater(movies[indexPath.row].releaseDate!)
        cell.movieDate.text = "Released: " + date
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedMovieId = movies?.results[indexPath.row].id
        performSegue(withIdentifier: "ToMovieDetailsFromSearch", sender: self)
    }
    
}

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text?.replacingOccurrences(of: " ", with: "%20")
        searchVM.searchText.accept(text ?? "")
        self.getMovies(page: page)
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            tableView.isHidden = true
        }
    }
}

extension SearchViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MovieDetailsViewController
        destination.movieId = selectedMovieId
    }
}
