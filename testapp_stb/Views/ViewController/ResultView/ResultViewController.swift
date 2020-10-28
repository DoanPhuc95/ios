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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        title = "結果"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: ".SFUIText-Medium", size:17)!]
        // set back Button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        view.backgroundColor = Colors.background
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
