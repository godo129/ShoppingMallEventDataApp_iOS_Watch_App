//
//  HomeViewController.swift
//  EventDataApp
//
//  Created by hong on 2021/12/16.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    let tableView = UITableView()
    
    var logoURLList: logoData!
    
    var shoppingMallManager = ShoppingMallManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        let headerLabel = UILabel(frame: header.bounds)
        headerLabel.text = "쇼핑몰 이벤트 보기"
        headerLabel.font = .systemFont(ofSize: 20, weight: .bold)
        headerLabel.textAlignment = .center
        header.addSubview(headerLabel)
        
        tableView.tableHeaderView = header
        
        shoppingMallManager.delegate = self
        shoppingMallManager.getNameList()
        
        // 줄 없애기
        tableView.separatorStyle = .none
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

//MARK : - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingMallList.count
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = ShoppingMallList[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        cell.textLabel?.textAlignment = .right
        cell.imageView?.kf.setImage(with: URL(string: logoURLList.logo[ShoppingMallList[indexPath.row]]!))
        cell.imageView?.frame.size.width = 300
        cell.imageView?.contentMode = .scaleAspectFit
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

extension HomeViewController: ShoppingMallDelegate {
    func didUpdateShopData(_ eventManager: ShoppingMallManager, data: ShoppingModel) {
        
        DispatchQueue.main.async {
            ShoppingMallList = data.ShopList
            self.logoURLList = data.logo
            self.view.addSubview(self.tableView)
            
        }
    }
    
    func didFailUpdateShopData(error: Error) {
        print(error)
    }
}
