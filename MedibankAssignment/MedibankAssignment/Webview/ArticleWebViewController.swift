//
//  ArticleWebViewController.swift
//  MedibankAssignment
//
//  Created by Rohit  on 13/2/2023.
//

import UIKit
import WebKit

class ArticleWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    private var webView = WKWebView()
    private var urlRequest: URLRequest
    let loadingView = CustomLoadingView(frame: .zero)

    init(webView: WKWebView = WKWebView(), urlRequest: URLRequest) {
        self.webView = webView
        self.urlRequest = urlRequest
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view = webView
        webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
        
        view.addSubview(loadingView)
        loadingView.pinCenterX(to: view)
        loadingView.pinCenterY(to: view)
        
        loadingView.addWidthConstraint(constant: SourceViewConstant.width)
        loadingView.addHeightConstraint(constant: SourceViewConstant.height)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingView.isHidden = true
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingView.isHidden = true
    }

}
