//
//  String.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/26.
//

import Foundation
import UIKit

extension String {
    func checkCardValidate() -> Bool {
        return NSPredicate.init(format: "SELF MATCHES %@", "[SHCDshcd](1[0-3]?|[2-9])").evaluate(with: self)
    }
    
//    static func matchRegex(for regex: String, in text: String) -> [String] {
//        do {
//            let regex = try NSRegularExpression(pattern: regex)
//            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
//            return results.map {
//                String(text[Range($0.range, in: text)!])
//            }
//        } catch let error {
//            return []
//        }
//    }
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
}


extension NotificationCenter {
    
}
