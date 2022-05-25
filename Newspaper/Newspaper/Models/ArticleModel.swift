//
//  Article.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 13.05.22.
//

import Foundation

/*
 {
 -"source": {
 "id": "al-jazeera-english",
 "name": "Al Jazeera English"
 },
 "author": "Al Jazeera",
 "title": "US stocks bounce back after chaotic week in markets",
 "description": "The S&P 500 advanced after flirting with bear-market territory -- defined by a 20% plunge from a recent record.",
 "url": "https://www.aljazeera.com/economy/2022/5/13/us-stocks-bounce-back-after-chaotic-week-in-markets",
 "urlToImage": "https://www.aljazeera.com/wp-content/uploads/2022/05/usa.jpg?resize=1200%2C630",
 "publishedAt": "2022-05-13T13:58:31Z",
 "content": "Stocks bounced back at the end of a chaotic week in financial markets, with a little help from Federal Reserve Chair Jerome Powells reassurance that bigger rate hikes would be off the table for now e… [+2462 chars]"
 }
 */

struct Article {
    
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var sourceName: String
    
    init (dictionary: Dictionary<String, Any>) {
        author = dictionary["author"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        url = dictionary["url"] as? String ?? ""
        urlToImage = dictionary["urlToImage"] as? String ?? ""
        publishedAt = dictionary["publishedAt"] as? String ?? ""
        sourceName = (dictionary["source"] as? Dictionary<String, Any> ?? ["":""])["name"] as? String ?? ""
    }
    
}
