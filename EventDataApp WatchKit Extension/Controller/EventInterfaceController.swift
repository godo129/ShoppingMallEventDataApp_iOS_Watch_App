//
//  EventInterfaceController.swift
//  EventDataApp WatchKit Extension
//
//  Created by hong on 2021/12/16.
//

import WatchKit
import Foundation


class EventInterfaceController: WKInterfaceController {

    var eventManger = EventManger()
    
    @IBOutlet var table: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setTitle(selectedShoppingMall)
        
        eventManger.delegate = self
        eventManger.getEventData(shoppingMall: selectedShoppingMall)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension EventInterfaceController: EventManagerDelegate {
    func didUpdateEventData(_ eventManger: EventManger, event: EventModel) {

        DispatchQueue.main.async {
            
            self.table.setNumberOfRows(event.imageURL.count, withRowType: "Row")
            
            for idx in 0..<event.imageURL.count {
                let row = self.table.rowController(at: idx) as! EventRowController
                
                row.image.imageFromUrl(event.imageURL[idx])
//                if let url = URL(string: event.imageURL[idx]) {
//                    // Fetch Image Data
//                    if let data = try? Data(contentsOf: url) {
//                        row.image.setImageData(data)
//                    }
//
//                }
   
            }
            
        }
    }
    func didFailUpdateEventData(error: Error) {
        print(error)
    }
}
