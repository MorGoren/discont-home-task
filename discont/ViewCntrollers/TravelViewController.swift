//
//  TravelViewController.swift
//  discont
//
//  Created by Mor Goren on 17/03/2022.
//

import UIKit

class TravelViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    
    private var collectionData: [RssItem]?
    private let feedParser = FeedParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Travel"
        
        setCollection()
        self.fetchData()
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: {_ in
            self.fetchData()
        })
    }

    private func setCollection() {
        self.collection.delegate = self
        self.collection.dataSource = self
        let nib = UINib(nibName: "TravelCell", bundle: nil)
        self.collection.register(nib, forCellWithReuseIdentifier: "TravelCell")
    }
    
    private func fetchData() {
        feedParser.parseFeed(sringUrl: "http://rss.cnn.com/rss/edition_travel.rss") { collectionData in
            self.collectionData = collectionData
            
            OperationQueue.main.addOperation {
                self.collection.reloadSections(IndexSet(integer: 0))
            }
        }
    }
}

extension TravelViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.collectionData?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collection.dequeueReusableCell(withReuseIdentifier: "TravelCell", for: indexPath) as? TravelCell else { return UICollectionViewCell() }
        if let data = self.collectionData?[indexPath.row] {
            cell.setData(data: data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webView = WebViewController()
        let arrayIndex = indexPath.row + indexPath.section
        
        guard let link = collectionData?[arrayIndex].link else { return }
        lastLink = link
        webView.openLink(stringUrl: link)
        self.present(webView, animated: true)
    }
}
