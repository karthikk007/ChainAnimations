//
//  ViewController.swift
//  ChainAnimations
//
//  Created by Karthik on 18/09/18.
//  Copyright © 2018 Karthik. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate: class {
    func didFinishAnimation()
}

class ViewController: UIViewController {
    
    var delegate: ViewControllerDelegate?
    
    var isAnimating: Bool = false
    
    var itemIndex: Int = 0
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Chain Animations"
        label.font = UIFont(name: "Futura", size: 34)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello there! Thanks so much for downloading our brand new app and giving us a try. Make sure to leave us a good review in the AppStore."
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
    
    override func viewDidAppear(_ animated: Bool) {
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        view.removeGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.transform = .identity
        titleLabel.alpha = 1
        
        bodyLabel.transform = .identity
        bodyLabel.alpha = 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .black
        setupStackView()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended && !isAnimating {
            isAnimating = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.titleLabel.alpha = 0
                    self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -150)
                })
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.bodyLabel.alpha = 0
                    self.bodyLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -150)
                }) { (_) in
                    self.delegate?.didFinishAnimation()
                    self.isAnimating = false
                }
            }
        }
    }
    
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        view.addSubview(stackView)
        
        // enables auto layout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

