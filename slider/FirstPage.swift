//
//  FirstPage.swift
//  slider
//
//  Created by 알버트 on 2017. 8. 14..
//  Copyright © 2017년 visionboy.me. All rights reserved.
//

import UIKit
import WebKit

class FirstPage: UIViewController,WKNavigationDelegate {

    
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var containerView: UIView!
    var activityIndicator = UIActivityIndicatorView()
    var webView: WKWebView!
    var loadingView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // 웹뷰에 뿌려질 경로 지정
        let url = NSURL(string: "http://172.20.80.100:8003/Home/index?uid=avene-18637588153&upw=8153")
        webView.loadRequest(NSURLRequest(URL: url!))
        webView.allowsBackForwardNavigationGestures = true
//        menuButton.target = self.revealViewController()
//        menuButton.action = Selector("revealToggle:")
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 최초 wkWebview설정
    override func loadView() {
        
        super.loadView()
        
        webView = WKWebView()
        
        webView.navigationDelegate = self
        
        view = webView
        
    }
    
    // 로딩 화면의 색상을 만드는 함수
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
        
    }
    
    // 웹뷰 시작시 로딩화면 그려준다.
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        loadingView.hidden = false
        
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        
        loadingView.center = containerView.center
        
        loadingView.backgroundColor = UIColorFromHex(0x444444, alpha: 0.7)
        
        loadingView.clipsToBounds = true
        
        loadingView.layer.cornerRadius = 10
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        
        activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        
        activityIndicator.center =  CGPointMake(loadingView.frame.size.width / 2, loadingView.frame.size.height / 2);
        
        activityIndicator.startAnimating()
        
        loadingView.addSubview(activityIndicator)
        
        webView.addSubview(loadingView)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        NSLog("add loading ")
        
    }
    
    // 웹뷰 로딩 완료시 로딩 화면 지워준다.
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        
        loadingView.hidden = true
        
        self.activityIndicator.stopAnimating()
        
        self.activityIndicator.removeFromSuperview()
        
        webView.willRemoveSubview(activityIndicator)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        NSLog("delete loading ")
        
    }
}
