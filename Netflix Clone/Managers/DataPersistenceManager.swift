//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Mahmoud Mohamed Atrees on 13/06/2023.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager{
    
    enum DataBaseError: Error{
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Movie, completion: @escaping (Result<Void, Error>) -> Void){
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let context = appdelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.overview = model.overview
        item.original_name = model.original_name
        item.poster_path = model.poster_path
        item.id = Int64(model.id)
        item.media_type = model.media_type
        item.original_language = model.original_language
        item.release_date = model.release_date
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DataBaseError.failedToSaveData))
        }
    }
    
    func fetchingTitlesFromDatabBase(completion: @escaping (Result<[TitleItem], Error>) -> Void){
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let context = appdelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do{
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch{
            completion(.failure(DataBaseError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let context = appdelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DataBaseError.failedToDeleteData))
        }
        
    }
}
