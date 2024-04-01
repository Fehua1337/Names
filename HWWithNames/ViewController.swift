//
//  ViewController.swift
//  HWWithNames
//
//  Created by Alisher Tulembekov on 01.04.2024.
//

import UIKit
import SnapKit
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    
    
    lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = "type a name"
        field.borderStyle = .roundedRect
        field.backgroundColor = .white
        return field
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("add name", for: .normal)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 255, alpha: 0.5)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setUI()
    }
    
    func addView() {
        view.addSubview(textField)
        view.addSubview(button)
    }
    
    func setUI() {
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc func buttonTapped() {
        let names = name()
        names.names = textField.text ?? ""
        textField.text = ""
        try! realm.write {
            realm.add(names)
            
        }
        navigationController?.pushViewController(ViewControllerNames(), animated: true)

    }

    
}

