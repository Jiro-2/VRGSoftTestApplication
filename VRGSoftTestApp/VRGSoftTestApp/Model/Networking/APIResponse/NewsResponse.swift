import Foundation


struct NewsResponse: Decodable {
    
    let status: String
    let copyright: String
    let numberResults: Int
    let results: [Article]
    
    private enum CodingKeys: String, CodingKey {
        
        case status, copyright, numberResults = "num_results", results
    }
}




struct Article: Decodable {
    
    let id: Int
    let title: String
    let abstract: String
    let url: String
    let publishedDate: String
    let source: String
    let author: String
    let media: [Media]
    
    private enum CodingKeys: String, CodingKey {
        
        case id, title, abstract, url, publishedDate = "published_date", source, author = "byline", media
    }
}



struct Media: Decodable {
    
    let type: String
    let metadata: [ImageData]
    
    private enum CodingKeys: String, CodingKey {
        case type, metadata = "media-metadata"
    }
}



struct ImageData: Decodable {
    
    let url: String
    let height: Int
    let width: Int
}
