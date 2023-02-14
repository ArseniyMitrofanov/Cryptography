//
//  ViewController.swift
//  Cryptography
//
//  Created by Арсений on 10.02.23.
//

import UIKit

class ViewController: UIViewController {
    let background: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let lab1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "key"), for: .normal)
        button.setTitle("\n\n      Lab 1", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .italicSystemFont(ofSize: 40)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.numberOfLines = 10
        return button
    }()
    let lab2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "key"), for: .normal)
        button.setTitle("\n\n      Lab 2", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .italicSystemFont(ofSize: 40)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.numberOfLines = 10
        return button
    }()
    let lab3: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "key"), for: .normal)
        button.setTitle("\n\n      Lab 3", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .italicSystemFont(ofSize: 40)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.numberOfLines = 10
        return button
    }()
    let lab4: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "key"), for: .normal)
        button.setTitle("\n\n      Lab 4", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .italicSystemFont(ofSize: 40)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.numberOfLines = 10
        return button
    }()
    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 20
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        lab1.addTarget(self, action: #selector(lab1Tapped), for: .touchUpInside)
        
    }
    
    func makeLayout(){
        background.frame = self.view.frame
        self.view.addSubview(background)
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(lab1)
        stackView.addArrangedSubview(lab2)
        stackView.addArrangedSubview(lab3)
        stackView.addArrangedSubview(lab4)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    @objc func lab1Tapped(){
        let vc = Lab1VC()
        vc.view.backgroundColor = .white
        let backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }

}

