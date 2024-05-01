//
//  Model.swift
//  MichaelMarkProject
//
//  Created by mac on 16/03/23.
//

import Foundation
import SwiftyJSON

class JsonModel {
    var data: JSON
    init(data:JSON) {
        self.data = data
    }
}

struct API {
    static let trendingMovies = "https://api.themoviedb.org/3/trending/all/day"
    static let genres = "https://api.themoviedb.org/3/genre/movie/list"
    static let searchMovies = "https://api.themoviedb.org/3/search/movie"
    static let getImage = "https://image.tmdb.org/t/p/w500/"
   
    static let genreSelection = "https://api.themoviedb.org/3/discover/movie"
    
    static let upcomingMovies = "https://api.themoviedb.org/3/movie/upcoming"
    static let popularMovies = "https://api.themoviedb.org/3/movie/popular"
    static let topRatedMovies = "https://api.themoviedb.org/3/movie/top_rated"
    static let nowPlaying = "https://api.themoviedb.org/3/movie/now_playing"
    static let similarMovies = "https://api.themoviedb.org/3/movie/464052/similar?api_key=b84aec0e45944b499ef12000744503ed&language=en-US&page=1"
}
