//
//  String.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/26.
//

import Foundation
import UIKit

enum CardInputCheck {
    case legal, blank, illegal
    
    var isValid: Bool {
        switch self {
        case .legal:
            return true
        default:
            return false
        }
    }
    
    var errorText: String {
        switch self {
        case .illegal:
            return "カード指定文字が不正です"
        case .blank:
            return "カードを入力してください"
        default:
            return ""
        }
    }
}

extension String {
    func checkCardValidate() -> CardInputCheck {
        if self.isEmpty { return .blank }
        if NSPredicate.init(format: "SELF MATCHES %@", "[SHCD](1[0-3]?|[2-9])").evaluate(with: self) {
            return .legal
        }
        return .illegal
    }
}

extension NSDate {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-dd-MM HH:mm"
        return formatter.string(from: self as Date)
    }
}


extension UIStackView {
    func removeAllSubviews() {
        while !arrangedSubviews.isEmpty {
            let view = arrangedSubviews.first
            view?.removeFromSuperview()
        }
    }
}

enum viewBorder: String {
    case left, right, bottom, top
}
extension UIView {
    func addBorder(vBorder: viewBorder, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        switch vBorder {
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        self.layer.addSublayer(border)
    }
}


extension UIViewController {
    private struct additional {
        static var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.height == UIScreen.main.bounds.height {
                self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - keyboardSize.height)
            }
        }
    }

    @objc func keyboardWillClose(notification: NSNotification) {
        self.view.frame = UIScreen.main.bounds
    }
    
    func showAnnounceDialog(title: String = "エラー", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    var indicator: UIActivityIndicatorView {
        set {
            objc_setAssociatedObject(self, &additional.indicator, newValue, .OBJC_ASSOCIATION_RETAIN)
            newValue.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            newValue.hidesWhenStopped = true
        }

        get {
            guard let indicator = objc_getAssociatedObject(self, &additional.indicator) as? UIActivityIndicatorView else {
                return UIActivityIndicatorView()
            }
            return indicator
        }
    }
    
    func showIndicator() {
        additional.indicator.style = UIActivityIndicatorView.Style.large
        additional.indicator.center = self.view.center
        self.view.addSubview(additional.indicator)
        additional.indicator.startAnimating()
    }
    
    func dismissIndicator() {
        additional.indicator.stopAnimating()
    }
}

