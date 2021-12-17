//
//  EventViewController.swift
//  EventDataApp
//
//  Created by hong on 2021/12/16.
//

import UIKit
import Kingfisher
import WebKit

class EventViewController: UIViewController {
    
    var eventData: EventModel!

    private var collectionView: UICollectionView!
    
    var eventManger = EventManger()
    
    var eventWeb = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.width/2-2+100)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.frame = view.bounds
        
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        eventManger.delegate = self
        eventManger.getEventData(shoppingMall: selectedShoppingMall)
        
        

        
        
        
    }


}

//MARK : - EventManagerDelegate
extension EventViewController: EventManagerDelegate {
 
    func didUpdateEventData(_ eventManger: EventManger, event: EventModel) {

        DispatchQueue.main.async {
            self.eventData = event
            
            self.view.addSubview(self.collectionView)
            
        }
    }
    
    func didFailUpdateEventData(error: Error) {
        print(error)
    }
    
    @objc func buttonTapped() {
        self.dismiss(animated: false, completion: nil)
    }
    
}

//MARK : - UICollectionVeiwDataSource, UICollectionViewDelegate

extension EventViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventData.imageURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EventCollectionViewCell
        
        cell.EventImage.kf.setImage(with: URL(string: eventData.imageURL[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//        button.setTitle("<", for: .normal)
//        button.setTitleColor(.systemTeal, for: .normal)
//        button.layer.opacity = 0.7
//        self.eventWeb.addSubview(button)
        
        let encodingUrl = eventData.detailURL[indexPath.row].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        self.eventWeb.load(URLRequest(url: URL(string: encodingUrl)!))
        
        
        
        eventWeb.frame = CGRect(x: 0, y: 40, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(eventWeb)
    }
    
    
}
