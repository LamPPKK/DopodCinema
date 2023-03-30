//
//  DayCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/26.
//

import UIKit

class DayCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var monthLabel: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setSelected()
    }

    func bindData(_ data: TransformShowTime) {
        
        monthLabel.text = data.day

        let result = data.date.components(separatedBy: " ")
        
        if result.count == 2 {
            dayLabel.text = result[1]
        }
        
        if data.isSelected {
            setSelected()
        } else {
           setUnselected()
        }
    }
    
    func setSelected() {
        monthLabel.textColor = .black
        monthLabel.font = .fontPoppinsBold(withSize: 17)
        
        dayLabel.textColor = .black
        dayLabel.font = .fontPoppinsBold(withSize: 24)
    }
    
    func setUnselected() {
        monthLabel.textColor = .black
        monthLabel.font = .fontPoppinsRegular(withSize: 11)
        
        dayLabel.textColor = .black
        dayLabel.font = .fontPoppinsRegular(withSize: 15)
    }
}
