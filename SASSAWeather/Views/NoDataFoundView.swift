//
//  NoDataFoundView.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import UIKit

class NoDataFoundView: UIView {

    @IBOutlet weak var messageImageView: UIImageView!{
        didSet{
            messageImageView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text = "Something went wrong"
            titleLabel.textColor = UIColor.black
                    titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        }
    }
    @IBOutlet weak var messageLabel: UILabel! {
        didSet{
            messageLabel.textColor = UIColor.lightGray
                    messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
            messageLabel.textAlignment = .center
        }
    }
    let nibName = "NoDataFoundView"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
