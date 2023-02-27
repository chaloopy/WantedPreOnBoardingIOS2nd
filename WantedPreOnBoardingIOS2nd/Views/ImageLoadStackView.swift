//
//  ImageLoadStackView.swift
//  WantedPreOnBoardingIOS2nd
//
//  Created by 차형용 on 2023/02/23.
//

import UIKit

class ImageLoadStackView: UIStackView {
    
    var isLoaded = false
    
    fileprivate let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.image = UIImage(systemName: "photo")
        view.tintColor = .link
        return view
    }()
    
    fileprivate let progressView: UIProgressView = {
        let view = UIProgressView()
        view.progress = 0.5
        return view
    }()
    
    fileprivate let imageLoadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 10
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal
        spacing = 10
        alignment = .center
        backgroundColor = .systemBackground
        setConstraints()
    }

    required init(coder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setConstraints() {
        [imageView, progressView, imageLoadButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview(subView)
        }
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            
            progressView.heightAnchor.constraint(equalToConstant: 1),
            
            imageLoadButton.widthAnchor.constraint(equalToConstant: 80),
            imageLoadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        imageLoadButton.addTarget(self, action: #selector(didTapLoadImage), for: .touchUpInside)
    }
    
    @objc func didTapLoadImage() {
        if !isLoaded {
            guard let url = URL(string: "https://picsum.photos/120/70") else {
                return
            }

            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }

                let image = UIImage(data: data)
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                }
            }.resume()
            isLoaded = true
        } else {
            self.imageView.image = UIImage(systemName: "photo")
            isLoaded = false
        }
    }
}
