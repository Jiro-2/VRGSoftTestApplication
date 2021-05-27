import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var id: Int64
    @NSManaged public var imageData: Data?
    @NSManaged public var url: String?
    @NSManaged public var title: String?
    @NSManaged public var summary: String?
    @NSManaged public var author: String?

}

extension Article : Identifiable {

}
