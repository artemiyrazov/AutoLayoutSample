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
        view.removeConstraints(view.constraints)
        squareView.removeConstraints(squareView.constraints)
        rectangleView.removeConstraints(rectangleView.constraints)
        addPermanentConstraints()
        if orientation.isPortrait {
            addPortraitConstraints()
        } else if orientation.isLandscape {
            addLanscapeConstraints()
        }
    }
    
    func addPermanentConstraints() {
        squareView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        squareView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        rectangleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    func addLanscapeConstraints() {
        squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        squareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        rectangleView.leadingAnchor.constraint(equalTo: squareView.trailingAnchor, constant: 40).isActive = true
        rectangleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        rectangleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func addPortraitConstraints() {
        squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        squareView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        rectangleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        rectangleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        rectangleView.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 40).isActive = true
    }
    
}
