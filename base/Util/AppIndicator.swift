//
//  AppIndicator.swift
//  base
//
//  Created by Desarrollo on 4/15/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation
import UIKit

struct AppIndicator {
    
    let viewForActivityIndicator = UIView()
    let view: UIView
    let navigationController: UINavigationController?
    let tabBarController: UITabBarController?
    let activityIndicatorView = UIActivityIndicatorView()
    let loadingTextLabel = UILabel()
    
    var navigationBarHeight: CGFloat { return navigationController?.navigationBar.frame.size.height ?? 0.0 }
    var tabBarHeight: CGFloat { return tabBarController?.tabBar.frame.height ?? 0.0 }
    
    func show(_ message: String) {
        viewForActivityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        viewForActivityIndicator.backgroundColor = AppColor.hex("004279").withAlphaComponent(0.9)
        view.addSubview(viewForActivityIndicator)
        
        activityIndicatorView.center = CGPoint(x: self.view.frame.size.width / 2.0, y: (self.view.frame.size.height - tabBarHeight - navigationBarHeight) / 2.0)
        
        loadingTextLabel.textColor = UIColor.white
        loadingTextLabel.text = message
        loadingTextLabel.font = UIFont(name: "Bariol-Bold", size: 20)
        loadingTextLabel.sizeToFit()
        loadingTextLabel.center = CGPoint(x: activityIndicatorView.center.x, y: activityIndicatorView.center.y + 30)
        viewForActivityIndicator.addSubview(loadingTextLabel)
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .white
        viewForActivityIndicator.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func hide() {
        viewForActivityIndicator.removeFromSuperview()
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
    
}
