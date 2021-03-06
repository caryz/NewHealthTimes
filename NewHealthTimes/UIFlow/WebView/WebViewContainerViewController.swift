//
//  WebViewContainerViewController.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/27/21.
//

import UIKit
import WebKit

protocol WebViewContainerDelegate: class {
    func exitWebViewContainer()
}

class WebViewContainerViewController: UIViewController, Storyboarded {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!

    var backButton: UIBarButtonItem!
    var forwardButton: UIBarButtonItem!

    var viewModel: WebViewContainerViewModel!
    weak var delegate: WebViewContainerDelegate?

    class func viewController(with viewModel: WebViewContainerViewModel) -> WebViewContainerViewController {
        let viewController = WebViewContainerViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.delegate = viewModel.delegate
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: viewModel.urlString) else {
            showSomethingWentWrongAlert(title: "Something went wrong",
                                        message: "Invalid URL: \(viewModel.urlString)") { [weak self] _ in
                self?.delegate?.exitWebViewContainer()
            }
            return
        }

        addButtons()
        addObservers()
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self

        let request = URLRequest(url: url)
        webView.load(request)

        delegate = viewModel?.delegate
        title = viewModel.title
    }

    private func addObservers() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title),
                            options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack),
                            options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward),
                            options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        } else if keyPath == "title", let title = webView.title {
            self.title = title
        } else if keyPath == "canGoBack" {
            backButton.isEnabled = webView.canGoBack
        } else if keyPath == "canGoForward" {
            forwardButton.isEnabled = webView.canGoForward
        }
    }

    func addButtons() {
        backButton = UIBarButtonItem(title: "Back", style: .plain, target: webView,
                                     action: #selector(webView.goBack))
        forwardButton = UIBarButtonItem(title: "Forward", style: .plain, target: webView,
                                        action: #selector(webView.goForward))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView,
                                      action: #selector(webView.reload))
        backButton.isEnabled = false
        forwardButton.isEnabled = false

        toolbarItems = [backButton, forwardButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
}

extension WebViewContainerViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
        showSomethingWentWrongAlert() { [weak self] _ in
            self?.delegate?.exitWebViewContainer()
        }
    }
}
