//
//  ViewController.swift
//  WantedPreOnBoardingIOS2nd
//
//  Created by 차형용 on 2023/02/23.
//

import UIKit

final class ViewController: UIViewController {
    
    let imageLoadViews = (1...5).map { _ in ImageLoadStackView() }
    
    fileprivate let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 15
        return view
    }()
    
    fileprivate let allImagesLoadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load All Images", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .link
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(allImagesLoadButton)
        
        setConstraints()
    }

    fileprivate func setConstraints() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            allImagesLoadButton.heightAnchor.constraint(equalToConstant: 40),
            allImagesLoadButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 5),
            allImagesLoadButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            allImagesLoadButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
        ])
        
       
        imageLoadViews.forEach { imageStack in
            stackView.addArrangedSubview(imageStack)
        }
        
        allImagesLoadButton.addTarget(self, action: #selector(didTapAllImageLoad), for: .touchUpInside)
    }
    
    @objc
    fileprivate func didTapAllImageLoad() {
        imageLoadViews.forEach {
            $0.didTapLoadImage()
        }
    }
}

