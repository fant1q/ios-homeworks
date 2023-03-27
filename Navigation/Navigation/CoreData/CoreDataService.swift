//
//  CoreDataService.swift
//  Navigation
//
//  Created by Денис Штоколов on 24.03.2023.
//

import Foundation
import CoreData
import Storage_Service

protocol CoreDataServiceProtocol {
    func addPost(_ post: Post)
    func deletePost(_ post: Post)
}

final class CoreDataService {
    
    static let shared = CoreDataService()
    
    public var favPosts: [FavoritePost] = []
    
    init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func reloadFolders() {
        let request = FavoritePost.fetchRequest()
        do {
            self.favPosts = try self.persistentContainer.viewContext.fetch(request)
        }
        catch {
            print("Error")
        }
    }
    
        func deleteAllData() {
            let storeContainer =
            persistentContainer.persistentStoreCoordinator
    
            for store in storeContainer.persistentStores {
                do {
                    try storeContainer.destroyPersistentStore(
                        at: store.url!,
                        ofType: store.type,
                        options: nil
                    )
                } catch { error }
            }
    
            persistentContainer = NSPersistentContainer(
                name: "CoreData")
    
            persistentContainer.loadPersistentStores {
                (store, error) in
            }
        }
}

extension CoreDataService: CoreDataServiceProtocol {
    
    func addPost(_ post: Post) {
        let addedPost = FavoritePost(context: persistentContainer.viewContext)
        addedPost.postDescription = post.description
        addedPost.author = post.author
        addedPost.image = post.image
        addedPost.likes = Int32(post.likes)
        addedPost.views = Int32(post.views)
        addedPost.isLiked = post.isLiked
        saveContext()
        reloadFolders()
    }
    
    func deletePost(_ post: Post) {
        let postToDelete = favPosts.first(where: { $0.postDescription == post.description })
        guard let postToDelete = postToDelete else {
            return
        }
        persistentContainer.viewContext.delete(postToDelete)
        saveContext()
        reloadFolders()
    }
}
