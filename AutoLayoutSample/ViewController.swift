//
//	ViewController.swift
// 	AutoLayoutSample
//

import UIKit

enum AutoLayoutType {
    case layoutAnchors, layoutConstraint,  visualFormatLanguage, advancedVisualFormatLanguage
}

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
    var constraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(squareView)
        view.addSubview(rectangleView)
    }
    
    // Choose layout type here!
    override func viewWillLayoutSubviews() {
        configureLayout(by: .advancedVisualFormatLanguage)
    }
    
    
    func configureLayout(by type: AutoLayoutType) {
        switch type {
        case .layoutAnchors:
            layoutWithAnchors()
        case .layoutConstraint:
            layoutWithNSLayoutConstraints()
        case .visualFormatLanguage:
            layoutWithVisualFormatLanguage()
        case .advancedVisualFormatLanguage:
            layoutWithAdvancedVisualFormatLanguage()
        }
    }
    
    func layoutWithAnchors() {
        squareView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        squareView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        squareView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        rectangleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        rectangleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        rectangleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        rectangleView.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 40).isActive = true
        
    }
    
    func layoutWithNSLayoutConstraints () {
        
        // Rectangle view layout configure
        NSLayoutConstraint(item: rectangleView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 20).isActive = true
        
        NSLayoutConstraint(item: rectangleView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -100).isActive = true
        
        NSLayoutConstraint(item: rectangleView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .height,
                           multiplier: 0.2,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: rectangleView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: squareView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 40).isActive = true
        
        // Square view layout configure
        NSLayoutConstraint(item: squareView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 100).isActive = true
        
        NSLayoutConstraint(item: squareView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 100).isActive = true
        
        NSLayoutConstraint(item: squareView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: squareView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 40).isActive = true
    }
    
    func layoutWithVisualFormatLanguage() {
        
        NSLayoutConstraint.deactivate(constraints)
        constraints.removeAll()
        
        let views = ["v0": squareView,
                     "v1": rectangleView]
        
        let squareLength: CGFloat = 100
        let metrics = ["squareLength": squareLength,
                       "rectangleHeight": view.bounds.height * 0.2,
                       "space": (view.bounds.width - squareLength) / 2]
        
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-space-[v0(squareLength)]-space-|",
            options: [],
            metrics: metrics,
            views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-40-[v0(squareLength)]-40-[v1(rectangleHeight)]",
            options: [],
            metrics: metrics,
            views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-40-[v1]-100-|",
            options: [],
            metrics: metrics,
            views: views))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func layoutWithAdvancedVisualFormatLanguage() {
        view.removeConstraints(view.constraints)
        squareView.removeConstraints(squareView.constraints)
        rectangleView.removeConstraints(rectangleView.constraints)
        
        let squareLength: CGFloat = 100
        let rectangeHeight = view.bounds.height * 0.2
        
        view.addConstraints(withVisualFormat: "H:|-m0-[v0(m1)]-m0-|", metrics: [(view.bounds.width - squareLength ) / 2, squareLength], views: [squareView])
        view.addConstraints(withVisualFormat: "V:|-40-[v0(m0)]-40-[v1(m1)]", metrics: [squareLength, rectangeHeight], views: [squareView, rectangleView])
        view.addConstraints(withVisualFormat: "H:|-40-[v0]-100-|", metrics: nil, views: [rectangleView])
    }
}


extension UIView {
    func addConstraints(withVisualFormat format: String, metrics: [Any]?, views: [UIView]) {
        var viewsDictionary: [String: UIView] = [:]
        var metricsDictionary: [String: Any] = [:]
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        if let metrics = metrics {
            for (index, metric) in metrics.enumerated() {
                let key = "m\(index)"
                metricsDictionary[key] = metric
            }
        }
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: format,
                                           options: [],
                                           metrics: metricsDictionary,
                                           views: viewsDictionary))
    }
}
