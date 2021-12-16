//
//  HomeViewController.swift
//  EventDataApp
//
//  Created by hong on 2021/12/16.
//

import UIKit

class HomeViewController: UIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        // 줄 없애기
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingMallList.count
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = ShoppingMallList[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        cell.textLabel?.textAlignment = .right
        cell.imageView?.image = UIImage(named: ShoppingMallList[indexPath.row])
        cell.imageView?.frame.size.width = 300
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.size.width)!/2.0

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedShoppingMall = ShoppingMallList[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "EventView")
        vc?.modalTransitionStyle = .flipHorizontal
        self.present(vc!, animated: true, completion: nil)
        
    }
    
}
