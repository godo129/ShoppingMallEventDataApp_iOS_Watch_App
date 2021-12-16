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

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setTitle("쇼핑몰 이벤트 보기")
        
        table.setNumberOfRows(ShoppingMallList.count, withRowType: "row")
        
        for idx in 0..<ShoppingMallList.count {
            let row = table.rowController(at: idx) as! HomeRowController
            row.image.setImage(UIImage(named: ShoppingMallList[idx]))
            row.label.setText(ShoppingMallList[idx])
            
        }
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
