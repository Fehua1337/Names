//
//  ViewControllerNames.swift
//  HWWithNames
//
//  Created by Alisher Tulembekov on 01.04.2024.
//

import Foundation
import SnapKit
import RealmSwift
import UIKit

class ViewControllerNames: UIViewController {
    
    
    let realm = try! Realm()
    lazy var names1 = [name]() {
        didSet {
            tableView.reloadData()
        }
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    override func viewDidLoad() {
        view.backgroundColor = .purple
        addView()
        setUI()
        getNames()
    }
    func addView() {
        view.addSubview(tableView)
        
        
    }
    func setUI() {
        tableView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(400)
            make.width.equalTo(300)
        }
    }
    func getNames() {
        let names = realm.objects(name.self)
        self.names1 = names.map({names in
        names})
    }
    private func deleteName(_ name: name) {
        try! realm.write {
            realm.delete(name)
        }
    }
}
extension ViewControllerNames: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = names1[indexPath.row].names
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { [weak self] (_, _, completionHandlesr) in
            self?.deleteName(at: indexPath)
            completionHandlesr(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    private func deleteName(at indexPath: IndexPath) {
        let names = names1[indexPath.row]
        deleteName(names)
        getNames()
        
    }
}
