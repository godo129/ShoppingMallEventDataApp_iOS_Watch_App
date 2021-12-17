//
//  EventModel.swift
//  EventDataApp
//
//  Created by hong on 2021/12/16.
//

import Foundation

struct EventModel {
    let ShopMallName : String
    let imageURL : [String]
    let detailURL: [String]
}



struct ShoppingModel {
    let ShopList : [String]
    let logo : logoData
}

struct logoData {
    let logo : [String : String]
}
