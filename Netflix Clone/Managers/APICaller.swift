//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Mahmoud Mohamed Atrees on 21/05/2023.
//

import Foundation

struct Constants{
    
    static let API_KEY = "22cde90febba8f829a10e0398b2053bc"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeAPIKey = "AIzaSyCXfweTNqgXtwql_FbxCUn6GkimrG31Of4"
    static let baseYoutubeURL = "https://youtube.googleapis.com/youtube/v3/search?"
    
}

enum APIError: Error{
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie] , Error>) -> Void){

        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}

        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                /*
                 // testing the json data in the console //
                 let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)*/

                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }

        })
        task.resume()

    }
    
    func getTrendingTvs(completion: @escaping (Result<[Movie] , Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                /*
                 // testing the json data in the console //
                 let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)*/
                
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
        
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie] , Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
        
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie] , Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
        
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie] , Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
        
    }


    func getDiscoverMovies(completion: @escaping (Result<[Movie] , Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
    }
    
    func search (with query: String,completion: @escaping (Result<[Movie] , Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
                    return
                }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
    }
    
    func getMovie (with query: String,completion: @escaping (Result<VideoElement , Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseYoutubeURL)q=\(query)&key=\(Constants.youtubeAPIKey)") else {
                    return
                }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
    }

    
    


    
}
