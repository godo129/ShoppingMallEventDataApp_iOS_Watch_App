//
//  HomeInterfaceController.swift
//  EventDataApp WatchKit Extension
//
//  Created by hong on 2021/12/16.
//

import WatchKit
import Foundation


class HomeInterfaceController: WKInterfaceController {
    
    @IBOutlet var table: WKInterfaceTable!
    
    var shoppingMallManager = ShoppingMallManager()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setTitle("쇼핑몰 이벤트 보기")
        
        shoppingMallManager.delegate = self
        
        shoppingMallManager.getNameList()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print(rowIndex)
        selectedShoppingMall = ShoppingMallList[rowIndex]
        self.pushController(withName: "EventView", context: nil)
    }


}

extension HomeInterfaceController: ShoppingMallDelegate {
    func didUpdateShopData(_ eventManager: ShoppingMallManager, data: ShoppingModel) {
    
        
        
        DispatchQueue.main.async {
            
            ShoppingMallList = data.ShopList
            self.table.setNumberOfRows(ShoppingMallList.count, withRowType: "row")
            
            for idx in 0..<ShoppingMallList.count {
                let row = self.table.rowController(at: idx) as! HomeRowController
                
                row.image.imageFromUrl(data.logo.logo[ShoppingMallList[idx]]!)
//                if let url = URL(string: data.logo.logo[ShoppingMallList[idx]]!) {
//                    // Fetch Image Data
//                    if let data = try? Data(contentsOf: url) {
//                        row.image.setImageData(data)
//                    }
//
//                }
                row.label.setText(ShoppingMallList[idx])
                
            }
        }
    }
    
    func didFailUpdateShopData(error: Error) {
        print(error)
    }
}


extension WKInterfaceImage {
    public func imageFromUrl(_ urlString: String) {

        if let url = NSURL(string: urlString) {

            let request = NSURLRequest(url: url as URL)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)

            let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
                if let imageData = data as Data? {
                    DispatchQueue.main.async {
                        self.setImageData(imageData)
                    }
                }
            });

            task.resume()
        }
    }
}
