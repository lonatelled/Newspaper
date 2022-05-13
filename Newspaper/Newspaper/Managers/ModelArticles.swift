//
//  ModelArticles.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 13.05.22.
//

//api key 5aaedffa0aec482e96e0775216cd38d4
/*https://newsapi.org/v2/everything?q=tesla&from=2022-04-13&sortBy=publishedAt&apiKey=5aaedffa0aec482e96e0775216cd38d4
 */

import Foundation

var articles: [Article] = []

var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}

func loadNews(completionHandler: (()->Void)?) {
    let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2022-04-13&sortBy=publishedAt&apiKey=5aaedffa0aec482e96e0775216cd38d4")
    let session = URLSession(configuration: .default)
    let downloadTask = session.downloadTask(with: url!) { urlFile, responce, error in
        if urlFile != nil {
            try? FileManager.default.copyItem(at: urlFile!, to: urlToData)
            parseNews()
            completionHandler?()
        }
    }
    downloadTask.resume()
}

func parseNews() {

    let data = try? Data(contentsOf: urlToData)
    if data == nil {
        return
    }
    
    let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
    if rootDictionaryAny == nil {
        return
    }
    
    let rootDictionary = rootDictionaryAny as? Dictionary<String, Any>
    if rootDictionary == nil {
        return
    }
    
    
    if let array = rootDictionary!["articles"] as? [Dictionary<String, Any>] {
        var returnArray: [Article] = []
        
        for dict in array {
            let newArticle = Article(dictionary: dict)
            returnArray.append(newArticle)
        }
        
        articles = returnArray
    }
    
    
}
