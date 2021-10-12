//
//  ViewController.swift
//  CodeCoverageExample
//
//  Created by Michael Dube on 2021/09/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hello code cov"
        label.textColor = .black
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        emptyCode()
    }
    
    func emptyCode() {
        print("hello")
    }


}

