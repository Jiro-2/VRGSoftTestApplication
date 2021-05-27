import Foundation
import class UIKit.UIApplication
import CoreData

protocol DatabaseManageable {
    
    func fetchObjects(_ type: NSManagedObject.Type, completion: ([Any]) ->())
    func deleteObject(ByID id: Int)
    func saveObject(withProperties properties: [String : Any])
    func checkAvailabilityObjectInDB(ByID id: Int) -> Bool
}



final class NewsDBManager: DatabaseManageable {
    
    
    private let context: NSManagedObjectContext
    
    
    
    init() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    
    //MARK: - Methods -
    
    
    func fetchObjects(_ type: NSManagedObject.Type, completion: ([Any]) -> ()) {
        
        do {
            
            let objects = try context.fetch(type.fetchRequest())
            completion(objects)
            
        } catch let error {
            
            assertionFailure(error.localizedDescription)
        }
    }
    
    
    
    func deleteObject(ByID id: Int) {
        
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Article")
        request.predicate = NSPredicate(format: "id == %lld", id)
        
        do {
            
            let objects = try context.fetch(request)
            
            
            for obj in objects {
                context.delete(obj)
            }
            
        } catch let error {
            
            assertionFailure(error.localizedDescription)
        }
        
        
        
        do {
            
            try context.save()
            
        } catch let error {
            
            assertionFailure(error.localizedDescription)
        }
    }
    
    
    
    
    
    func saveObject(withProperties properties: [String : Any]) {
        
        let article = Article(context: context)
        properties.forEach { property, value in
            
            article.setValue(value, forKey: property)
        }
                
        
        do {
            
            try self.context.save()
            
        } catch let error {
            
            assertionFailure(error.localizedDescription)
        }
    }
    
    
    
    func checkAvailabilityObjectInDB(ByID id: Int) -> Bool {
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Article")
        let predicate = NSPredicate(format: "id == %lld", id)
        request.predicate = predicate
        var result = 0
        
        do {
            
           let count = try context.count(for: request)
           result = count
            
        } catch let error {
            
            assertionFailure(error.localizedDescription)
        }
        
       return result > 0
    }
}
