//
//  Extensions.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit

class AppButton: UIButton {
    let indicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.tintColor = .white
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            indicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}


extension UIViewController {
    
    func configTitles(title: String) {
        self.navigationItem.title = title
    }
    
    func alert(success: Bool, withImage: Bool, message: String, completion: @escaping() -> Void)  {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let imageView: UIImageView = {
            let img = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            return img
        }()
        switch success {
        case true:
            imageView.image = #imageLiteral(resourceName: "done24Px")
            alert.title = "\nOperation success"
            alert.message = message
        case false:
            imageView.image = #imageLiteral(resourceName: "removeCircleOutline24Px")
            alert.title = "\nOperation Failed"
            let attributedString = NSAttributedString(string: message, attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
                NSAttributedString.Key.foregroundColor : UIColor.red
            ])
            alert.setValue(attributedString, forKey: "attributedMessage")
            alert.message = message
        }
        if withImage {
            alert.view.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 10),
                imageView.widthAnchor.constraint(equalToConstant: 30),
                imageView.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        let cancel = UIAlertAction(title: "Ok", style: .destructive) { _ in
            alert.dismiss(animated: true, completion: nil)
            completion()
        }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}


extension UINavigationController {
    func popViewControllerWithHandler(completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: true)
        CATransaction.commit()
    }
    func pushViewController(viewController: UIViewController, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}

extension UIView {
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = #colorLiteral(red: 0.9882352941, green: 0.4196078431, blue: 0.4078431373, alpha: 1)
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 30)
        layer.shadowRadius = 30
    }
    
    func dropViewShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }
}

@IBDesignable class TabBarWithCorners: UITabBar {
    @IBInspectable var color: UIColor?
    @IBInspectable var radii: CGFloat = 15.0
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    func dropviewShadow() {
        layer.masksToBounds = false
        layer.shadowColor = #colorLiteral(red: 0.9882352941, green: 0.4196078431, blue: 0.4078431373, alpha: 1)
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: -30)
        layer.shadowRadius = 30
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = #colorLiteral(red: 0.9882352941, green: 0.4196078431, blue: 0.4078431373, alpha: 0.25)
        shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
        shapeLayer.lineWidth = 0
        dropviewShadow()
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: bounds, cornerRadius: radii).cgPath
        
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radii, height: 0.0))
        
        return path.cgPath
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame
        tabFrame.size.height = 65 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? CGFloat.zero)
        tabFrame.origin.y = self.frame.origin.y + ( self.frame.height - 65 - (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? CGFloat.zero))
        self.layer.cornerRadius = 20
        self.frame = tabFrame
        
        self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })
        
        
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
