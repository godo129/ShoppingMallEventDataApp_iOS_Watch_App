//
//  EventCollectionViewCell.swift
//  EventDataApp
//
//  Created by hong on 2021/12/16.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    var EventImage: UIImageView = {
            let EventImage = UIImageView()
            EventImage.backgroundColor = .white
            EventImage.clipsToBounds = true
            EventImage.contentMode = .scaleToFill
            return EventImage
        }()
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(EventImage)
            EventImage.frame = contentView.bounds
     
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
