//
//  GlobalMethods.swift
//  FinalSpace
//
//  Created by Василий Полторак on 20.05.2022.
//

import UIKit

class GlobalMethods {
    
    static let shared = GlobalMethods()
    
    private init() {}
    
    func addActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}



