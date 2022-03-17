//
//  WebViewController.swift
//  discont
//
//  Created by Mor Goren on 17/03/2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func openLink(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        webView.load(URLRequest(url: url))
    }
}
