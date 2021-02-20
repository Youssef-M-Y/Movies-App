//
//  SearchMovieCell.swift
//  Movies App
//
//  Created by OmarMansour on 2/18/21.
//  Copyright © 2021 Youssef. All rights reserved.
//

import UIKit
import Cosmos

class SearchMovieCell: UITableViewCell{
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieStarRating: CosmosView!
    @IBOutlet weak var movieRating: UILabel!
}
