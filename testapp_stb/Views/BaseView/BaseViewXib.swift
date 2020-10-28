//
//  BaseViewXib.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/21.
//

import Foundation
import UIKit

class BaseViewXib: UIView {
    private var view : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        view?.frame = bounds
        addSubview(view ?? UIView())
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.backgroundColor = Colors.background
        initView()
    }
    
    func initView() {}
}
extension BaseViewXib {
    func setBackground(color: UIColor) {
        view?.backgroundColor = color
    }
}
