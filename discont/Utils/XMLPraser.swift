//
//  XMLPraser.swift
//  discont
//
//  Created by Mor Goren on 17/03/2022.
//

import Foundation

struct RssItem {
    var title: String = .empty
    var description: String = .empty
    var link: String = .empty
    var pubdate: String = .empty
    var imageUrl: String = .empty
}

typealias RssComplitionHandler = (([RssItem]) -> Void)

class FeedParser: NSObject {
    private var rssItems: [RssItem] = []
    private var currentElement: String = .empty
    private var currentKey: String = .empty
    private var currentRssItem: RssItem = RssItem()
    private var completionHandler: RssComplitionHandler?
    
    func parseFeed(sringUrl: String, completionHandler: RssComplitionHandler?) {
        self.completionHandler = completionHandler
        self.rssItems = []
        
        guard let url = URL(string: sringUrl) else { return }
        let request = URLRequest(url: url)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            
            // parse XML data
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        
        task.resume()
    }
}

extension FeedParser: XMLParserDelegate {
    // called on opening tab
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        switch currentElement {
        case "item": currentRssItem = RssItem()
        case "media:content":
            if currentRssItem.imageUrl == .empty { // the first image
                currentRssItem.imageUrl = attributeDict["url"]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? .empty
            }
        default: break
        }
    }
    
    // called when get data in tab
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let cleanString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch currentElement {
        case "title": currentRssItem.title = cleanString
        case "description": currentRssItem.description = cleanString
        case "link": currentRssItem.link = cleanString
        case "pubdate": currentRssItem.pubdate = cleanString
        default: break
        }
    }
    
    // called on closing tab
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            rssItems.append(currentRssItem)
        }
    }
    
    // called when reach the end of the XML page
    func parserDidEndDocument(_ parser: XMLParser) {
        completionHandler?(rssItems)
    }
    
    // in case of an error
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
