//
//  WebViewController.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/26/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    // MARK: - Actions
    @objc
    private func backBtnTapped() {
        webView.goBack()
    }
    @objc
    func refreshBtnTapped() {
        webView.reload()
    }
    @objc
    private func forwardBtnTapped() {
        webView.goForward()
    }
    
    private func setUpViews() {
        navigationItem.leftBarButtonItems = [backBtn, refreshBtn, forwardBtn]
        
        view.addSubview(webView)
        webView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 0, right: view.rightAnchor, paddingRight: 0, width: 0, height: 0)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        guard let url = URL(string: "https://www.bottlerocketstudios.com/") else {
            fatalError("Broken url")
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - Properties
    private let urlStr = "https://www.bottlerocketstudios.com/"
    
    var activityIndicator = UIActivityIndicatorView()
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    private lazy var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: ImageHelper.webBack.set(), style: .done, target: self, action: #selector(backBtnTapped))
        btn.tintColor = .white
        return btn
    }()
    
    private lazy var refreshBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: ImageHelper.webRefresh.set(), style: .done, target: self, action: #selector(refreshBtnTapped))
        btn.tintColor = .white
        return btn
    }()
    
    private lazy var forwardBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: ImageHelper.webForward.set(), style: .done, target: self, action: #selector(forwardBtnTapped))
        btn.tintColor = .white
        return btn
    }()
}

extension WebViewController: WKNavigationDelegate, ActivityIndicatorPresenter {
    
    // MARK: - WKNavDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
     if let host = navigationAction.request.url?.host {
         if host.contains("bottlerocketstudios.com") {
             decisionHandler(.allow)
             return
         }
     }

     decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showNoActionAlert(titleStr: "Error Loading Info", messageStr: error.localizedDescription, style: .cancel)
    }
}

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
