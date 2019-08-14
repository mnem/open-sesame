//
//  ViewController.swift
//  open-sesame
//
//  Created by David Wagner on 14/08/2019.
//  Copyright © 2019 David Wagner. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createWebView()
        
        let url = URL(string: "https://noiseandheat.app/open-sesame/")!
        let request = URLRequest(url: url)
        webView.load(request)
    }

    private func createWebView() {
        let config = WKWebViewConfiguration()
        config.setURLSchemeHandler(AccessProtocolHandler(), forURLScheme: "access")
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        let views = ["view":webView!]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[view]-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: views)
        NSLayoutConstraint.activate(horizontalConstraints)
        NSLayoutConstraint.activate(verticalConstraints)
    }
    
}

class AccessProtocolHandler: NSObject, WKURLSchemeHandler {
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        UIApplication.shared.open(urlSchemeTask.request.url!) { (successful) in
            urlSchemeTask.didFailWithError(NSError(domain: "foo", code: 1, userInfo: nil))
        }
    }

    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        
    }
}
