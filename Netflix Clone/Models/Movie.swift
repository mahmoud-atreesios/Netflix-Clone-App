//
//  Movie.swift
//  Netflix Clone
//
//  Created by Mahmoud Mohamed Atrees on 21/05/2023.
//

import Foundation


struct TrendingMovieResponse: Codable{
    let results: [Movie]
}


struct Movie: Codable{
    let id: Int
    let media_type: String?
    let original_language: String?
    let original_title: String?
    let original_name: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let vote_count: Int
    let vote_average: Double
    
}


 
