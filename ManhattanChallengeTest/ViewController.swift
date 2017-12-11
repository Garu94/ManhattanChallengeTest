//
//  ViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 09/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let overviewView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let foodView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let accomodationView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let transportView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    let entertainmentView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let cultureView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let othersView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let plusView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    
    
    //Setup layout of views
    private func setupLayout() {
        view.addSubview(overviewView)
        
        NSLayoutConstraint.activate([
            overviewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            overviewView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            overviewView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            overviewView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
//            topSubView.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        
        //SETUP STACK VIEW
        let firstRowStackView = UIStackView(arrangedSubviews: [foodView, accomodationView, transportView])
        firstRowStackView.translatesAutoresizingMaskIntoConstraints = false
        firstRowStackView.distribution = .fillEqually
        
        let secondRowStackView = UIStackView(arrangedSubviews: [entertainmentView, cultureView, othersView])
        secondRowStackView.translatesAutoresizingMaskIntoConstraints = false
        secondRowStackView.distribution = .fillEqually
        
        
        view.addSubview(firstRowStackView)
        view.addSubview(secondRowStackView)
        
        NSLayoutConstraint.activate([
            firstRowStackView.topAnchor.constraint(equalTo: overviewView.bottomAnchor),
            firstRowStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            firstRowStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            firstRowStackView.heightAnchor.constraint(equalToConstant: view.frame.size.width/3),
            
            secondRowStackView.topAnchor.constraint(equalTo: firstRowStackView.bottomAnchor),
            secondRowStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            secondRowStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            secondRowStackView.heightAnchor.constraint(equalToConstant: view.frame.size.width/3)
            ])
        
        //SETUP + BUTTON
        view.addSubview(plusView)
        
        NSLayoutConstraint.activate([
            plusView.topAnchor.constraint(equalTo: secondRowStackView.bottomAnchor, constant: 10),
            plusView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            plusView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusView.widthAnchor.constraint(equalToConstant: view.frame.size.width/3)
            ])
        
        
    }

}




















