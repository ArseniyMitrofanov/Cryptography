//
//  ViewController.swift
//  Cryptography
//
//  Created by Арсений on 10.02.23.
//

import UIKit

class ViewController: UIViewController {
    let lab1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.layer.cornerRadius = 30
        button.setTitle("Lab 1", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        return button
    }()
    let lab2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.layer.cornerRadius = 30
        button.setTitle("Lab 2", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        return button
    }()
    let lab3: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.layer.cornerRadius = 30
        button.setTitle("Lab 3", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        return button
    }()
    let lab4: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.layer.cornerRadius = 30
        button.setTitle("Lab 4", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
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
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(lab1)
        stackView.addArrangedSubview(lab2)
        stackView.addArrangedSubview(lab3)
        stackView.addArrangedSubview(lab4)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
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

