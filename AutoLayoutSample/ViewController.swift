//
//	ViewController.swift
// 	AutoLayoutSample
//

import UIKit

class ViewController: UIViewController {
    
    let squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(squareView)
        view.addSubview(rectangleView)
    }
    
    override func viewWillLayoutSubviews() {
        configureLayout()
    }
    
    
    func configureLayout() {
        squareView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        squareView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        squareView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        rectangleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        rectangleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        rectangleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        rectangleView.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 40).isActive = true
        
    }
}
