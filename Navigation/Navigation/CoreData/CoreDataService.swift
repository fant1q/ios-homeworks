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
    private var fecthedResultsController: NSFetchedResultsController<FavoritePost> = NSFetchedResultsController()
    
    init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return backgroundContext
    }()
    
    private func saveContext () {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
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
    
    func setupFecthedResultsController() -> NSFetchedResultsController<FavoritePost> {
        let fetchRequest = FavoritePost.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "author", ascending: true)
        fetchRequest.sortDescriptors = [
            sortDescriptor
        ]
        fetchRequest.predicate = NSPredicate(format: "isLiked == true")
        let fecthedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        do {
            try fecthedResultsController.performFetch()
        }
        catch {
            print(error)
        }
        return fecthedResultsController
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
            } catch {  }
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
        backgroundContext.perform {
            let addedPost = FavoritePost(context: self.backgroundContext)
            addedPost.postDescription = post.description
            addedPost.author = post.author
            addedPost.image = post.image
            addedPost.likes = Int32(post.likes)
            addedPost.views = Int32(post.views)
            addedPost.isLiked = post.isLiked
            self.saveContext()
        }
    }
    
    func deletePost(_ post: Post) {
        let index = self.favPosts.firstIndex(where: { $0.postDescription == post.description })
        guard let index = index else {
            return
        }
        self.persistentContainer.viewContext.delete(self.favPosts[index])
        self.favPosts.remove(at: index)
        self.saveContext()
    }
    
    func deleteFavPost(_ post: FavoritePost) {
        persistentContainer.viewContext.delete(post)
        self.saveContext()
    }
    
    func searchPosts(_ author: String) -> NSFetchedResultsController<FavoritePost> {
        let fetchRequest = FavoritePost.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "author", ascending: true)
        fetchRequest.sortDescriptors = [
            sortDescriptor
        ]
        fetchRequest.predicate = NSPredicate(format: "(author contains[c] %@) AND (isLiked == true)", author)
        let fecthedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: persistentContainer.viewContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        do {
            try fecthedResultsController.performFetch()
        }
        catch {
            print(error)
        }
        return fecthedResultsController
    }
}
