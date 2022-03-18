//
//  IntoViewController.swift
//  discont
//
//  Created by Mor Goren on 17/03/2022.
//

import UIKit

class IntoViewController: UIViewController {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var clock: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        linkButton.titleLabel?.text = .empty
        title = "Intro Page"
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let date = Date()
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "hh:MM:ss a"
            self.clock.text = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "dd/MM/yyyy"
            self.date.text = dateFormatter.string(from: date)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        linkButton.titleLabel?.adjustsFontSizeToFitWidth = true
        linkButton.titleLabel?.numberOfLines = 0
        linkButton.titleLabel?.text = lastLink
        linkButton.isHidden = lastLink.isEmpty
    }
    
    @IBAction func openLink(_ sender: Any) {
        if !lastLink.isEmpty {
            let webView = WebViewController()
            webView.openLink(stringUrl: lastLink)
            self.present(webView, animated: true)
        }
    }
}
