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
    
    lazy var permanentConstraints: [NSLayoutConstraint] = [
        squareView.widthAnchor.constraint(equalToConstant: 100),
        squareView.heightAnchor.constraint(equalToConstant: 100),
        rectangleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
    ]
    
    lazy var lanscapeConstraints: [NSLayoutConstraint] = [
        squareView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        squareView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
        rectangleView.leadingAnchor.constraint(equalTo: self.squareView.trailingAnchor, constant: 40),
        rectangleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
        rectangleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    ]
    
    lazy var portraitConstraints: [NSLayoutConstraint] = [
        squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        squareView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
        rectangleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        rectangleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
        rectangleView.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 40),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(squareView)
        view.addSubview(rectangleView)
        
        NSLayoutConstraint.activate(permanentConstraints)
        configureLayout()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let self = self else { return }
            self.configureLayout()
        })
    }
    
    
    
    func configureLayout() {
        guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else { return }   
        if orientation.isPortrait {
            NSLayoutConstraint.deactivate(lanscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        } else if orientation.isLandscape {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(lanscapeConstraints)
        }
        view.layoutIfNeeded()
    }
    
}
