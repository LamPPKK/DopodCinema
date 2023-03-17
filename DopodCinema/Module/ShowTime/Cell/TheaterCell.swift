//
//  TheaterCell.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/17.
//

import UIKit

class TheaterCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var theaterName: UILabel!
    @IBOutlet private weak var theaterAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        theaterName.textColor = Constant.Color.color3D5BF6
        theaterName.font = .fontPoppinsSemiBold(withSize: 14)
        
        theaterAddress.textColor = Constant.Color.color2B2F31
        theaterAddress.font = .fontPoppinsRegular(withSize: 12)
    }

    func bindData(_ data: MovieTheaterSearchInfo) {
        theaterName.text = data.name
        theaterAddress.text = data.vicinity
    }
}
