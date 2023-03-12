//
//  CustomizePageControl.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/08.
//

import UIKit

class CustomPageControl: UIPageControl {

    @IBInspectable var currentPageImage: UIImage?

    @IBInspectable var otherPagesImage: UIImage?

    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }

    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        pageIndicatorTintColor = .clear
        currentPageIndicatorTintColor = .clear
        clipsToBounds = false
    }

    private func updateDots() {

//        var dotViews: [UIView] = subviews
//        if #available(iOS 14, *) {
//            let pageControl = dotViews[0]
//            let dotContainerView = pageControl.subviews[0]
//            dotViews = dotContainerView.subviews
//        }
//
//        for (index, subview) in dotViews.enumerated() {
//            let imageView: UIImageView
//            if let existingImageview = getImageView(forSubview: subview) {
//                imageView = existingImageview
//            } else {
//                imageView = UIImageView(image: otherPagesImage)
//                // Modify image size
//                imageView.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
//                imageView.center = subview.center
//                subview.addSubview(imageView)
//                subview.clipsToBounds = false
//            }
//            imageView.image = currentPage == index ? currentPageImage : otherPagesImage
//        }
        
        if #available(iOS 14, *) {
            for index in 0..<self.numberOfPages {
                if index == currentPage {
                    self.setIndicatorImage(UIImage(named: "ic_active_dot"), forPage: index)
                } else {
                    self.setIndicatorImage(UIImage(named: "ic_inactive_dot"), forPage: index)
                }
            }
        } else {
            
        }
    }

    private func getImageView(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        } else {
            let view = view.subviews.first { (view) -> Bool in
                return view is UIImageView
            } as? UIImageView

            return view
        }
    }
}
