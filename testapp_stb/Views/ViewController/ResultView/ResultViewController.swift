//
//  ResultViewController.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/12.
//


import UIKit

class ResultViewController : UIViewController {
    var result: ResultResponse?
    
    @IBOutlet weak var stackResultView: UIStackView!
    @IBOutlet weak var navbar: UIView!
    
//    init(result: ResultResponse) {
//        super.init()
//        self.result = result
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navbar.addBorder(vBorder: .bottom, color: Colors.border, width: 0.5)
        view.backgroundColor = Colors.background
        
        showData()
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func showData() {
        if result!.error != nil {
            for data in result!.error! {
                let cardView = HandResultView()
                cardView.setData(hand: data.msg!, card: data.card!)
                cardView.handLb.textColor = .red
                stackResultView.addArrangedSubview(cardView)
            }
        }
        if result!.result != nil {
            for data in result!.result! {
                let cardView = HandResultView()
                cardView.setData(hand: data.hand!, card: data.card!)
                stackResultView.addArrangedSubview(cardView)
            }
        }
    }
}
