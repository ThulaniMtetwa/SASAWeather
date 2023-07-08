//
//  UITableView+ErrorView.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import UIKit

extension UITableView {
    
    func setEmptyView(title: String, message: String, messageImage: UIImage) {
        
        let view = NoDataFoundView(frame: self.bounds)
        
        view.messageImageView.image = messageImage
        view.titleLabel.text = title
        view.messageLabel.text = message
        view.messageLabel.numberOfLines = 0
        view.messageLabel.textAlignment = .center
        
        UIView.animate(withDuration: 1, animations: {
                    
            view.messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
                }, completion: { (finish) in
                    UIView.animate(withDuration: 1, animations: {
                        view.messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
                    }, completion: { (finish) in
                        UIView.animate(withDuration: 1, animations: {
                            view.messageImageView.transform = CGAffineTransform.identity
                        })
                    })
                    
                })
        
        self.backgroundView = view
        self.separatorStyle = .none
    }
    
    func restore() {
        
        self.backgroundView = nil
        self.separatorStyle = .singleLine
        
    }
    
}
