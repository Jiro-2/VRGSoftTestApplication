import Foundation


struct NewsResponse: Decodable {
    
    let status: String
    let copyright: String
    let numberResults: Int
    let results: [ArticleResponse]
    
    private enum CodingKeys: String, CodingKey {
        
        case status, copyright, numberResults = "num_results", results
    }
}




struct ArticleResponse: Decodable {
    
    let id: Int
    let title: String
    let abstract: String
    let url: String
    let author: String
    let media: [MediaResponse]
    
    private enum CodingKeys: String, CodingKey {
        
        case id, title, abstract, url, author = "byline", media
    }
}



struct MediaResponse: Decodable {
    
    let type: String
    let metadata: [ImageDataResponse]
    
    private enum CodingKeys: String, CodingKey {
        case type, metadata = "media-metadata"
    }
}



struct ImageDataResponse: Decodable {
    
    let url: String
    let height: Int
    let width: Int
}
