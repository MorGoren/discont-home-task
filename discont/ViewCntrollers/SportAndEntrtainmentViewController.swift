//
//  SportAndEntrtainmentViewController.swift
//  discont
//
//  Created by Mor Goren on 17/03/2022.
//

import UIKit

class SportAndEntrtainmentViewController: UIViewController {
    
    @IBOutlet weak var tabel: UITableView!
    
    private var tabelSportData: [RssItem]?
    private var tabelEntrtainmentData: [RssItem]?
    private let sportFeedParser = FeedParser()
    private let entrtainmenFeedParser = FeedParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sport and Entrtainment"
        
        setTabel()
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: {_ in
            self.fetchData()
        })
    }
    
    private func setTabel() {
        self.tabel.delegate = self
        self.tabel.dataSource = self
        self.tabel.register(UINib(nibName: "SportAndEntrtainmentCell", bundle: nil), forCellReuseIdentifier: "SportAndEntrtainmentCell")
        self.tabel.register(UINib(nibName: "HeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderCell")
    }
    
    private func fetchData() {
        sportFeedParser.parseFeed(sringUrl: "http://rss.cnn.com/rss/edition_sport.rss") { sportData in
            self.tabelSportData = sportData
            
            OperationQueue.main.addOperation {
                self.tabel.reloadData()
            }
        }
        
        entrtainmenFeedParser.parseFeed(sringUrl: "http://rss.cnn.com/rss/edition_entertainment.rss") { entrtainmentData in
            self.tabelEntrtainmentData = entrtainmentData
            
            OperationQueue.main.addOperation {
                self.tabel.reloadData()
            }
        }
    }
}

extension SportAndEntrtainmentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tabel.dequeueReusableHeaderFooterView(withIdentifier: "HeaderCell") as? HeaderCell else { return UIView() }
        switch section {
        case 0: header.setTitle(title: "Sport", imageName: "sportscourt")
        case 1: header.setTitle(title: "Entertainment", imageName: "theatermasks")
        default: break
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return tabelSportData?.count ?? 3
        case 1: return tabelEntrtainmentData?.count ?? 3
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tabel.dequeueReusableCell(withIdentifier: "SportAndEntrtainmentCell", for: indexPath) as? SportAndEntrtainmentCell else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            if let data = tabelSportData?[indexPath.row] {
                cell.setData(data: data, backgroundColor: UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 0.2))
            }
        case 1:
            if let data = tabelEntrtainmentData?[indexPath.row] {
                cell.setData(data: data, backgroundColor: UIColor(red: 88/255, green: 214/255, blue: 86/255, alpha: 1))
            }
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webView = WebViewController()
        switch indexPath.section {
        case 0:
            guard let link = tabelSportData?[indexPath.row].link else { return }
            webView.openLink(stringUrl: link)
        case 1:
            guard let link = tabelEntrtainmentData?[indexPath.row].link else { return }
            webView.openLink(stringUrl: link)
        default: break
        }
        
        self.present(webView, animated: true)
    }
}
