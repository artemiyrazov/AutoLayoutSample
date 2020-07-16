//
//	ViewController.swift
// 	AutoLayoutSample
//

import UIKit

class ViewController: UIViewController {
    
    var animatedConstraint: NSLayoutConstraint!
    var isAnimating = false
    
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
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Start animation", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(squareView)
        view.addSubview(rectangleView)
        view.addSubview(button)
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
        animatedConstraint = rectangleView.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 40)
        animatedConstraint.isActive = true
        
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func buttonTapped() {
        if isAnimating {
            rectangleView.layer.removeAllAnimations()
            self.animatedConstraint.constant = 40
            self.view.layoutIfNeeded()
            button.setTitle("Start animating", for: .normal)
        } else {
            UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: {
                self.animatedConstraint.constant += 50
                self.view.layoutIfNeeded()
            }, completion: nil)
            button.setTitle("Stop animating", for: .normal)
        }
        isAnimating.toggle()
    }
}
