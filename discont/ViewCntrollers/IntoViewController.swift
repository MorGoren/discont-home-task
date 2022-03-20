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
        linkButton.titleLabel?.adjustsFontSizeToFitWidth = true
        linkButton.titleLabel?.numberOfLines = 0
        title = "Intro Page"
        
        setTime()
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.setTime()
        }
    }
    
    private func setTime() {
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh:MM a"
        self.clock.text = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.date.text = dateFormatter.string(from: date)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        linkButton.setTitle(lastLink, for: .normal)
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
