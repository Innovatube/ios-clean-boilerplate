//
//  CarCell.swift
//  CarBid-VIPER
//
//  Created by Do Dinh Thy  Son  on 3/3/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

class CarCell : UITableViewCell, NibLoadableView, ReusableView {
  
  @IBOutlet weak var bidButton: UIButton!
  @IBOutlet weak var carImageView: UIImageView!
  @IBOutlet weak var descriptionMessageTextView: UITextView!
  @IBOutlet weak var carNameLabel: UILabel!
  @IBOutlet weak var yomLabel: UILabel!
  @IBOutlet weak var biddingLabel: UILabel!
  
  var carCellDelegate : CarCellDelegate?
  var indexPath: IndexPath?
  var carEntity: CarEntity?
    
  {
    willSet{
      carNameLabel.text = newValue!.name
      descriptionMessageTextView.text = newValue!.description
      yomLabel.text = "\(newValue!.yom)"
      if newValue!.numberOfBids != nil {
        if newValue!.numberOfBids! > 0 {
          biddingLabel.text = "\(newValue!.numberOfBids!) people is bidding"
          showPriceLabel()
        }
      } else {
        showBidButton()
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    bidButton.backgroundColor = Constants.Color.orange
    carImageView.backgroundColor = Constants.Color.green
    descriptionMessageTextView.backgroundColor = Constants.Color.blue
    carNameLabel.backgroundColor = Constants.Color.blue
    yomLabel.backgroundColor = Constants.Color.blue
    bidButton.backgroundColor = Constants.Color.orange
    biddingLabel.isHidden = true
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if bidButton.allTargets.count == 0 {
      addTargetToBidButton()
    }
  }
  
  @IBAction func bidButtonTouchUpInsideAction(_ sender: UIButton) {
    carCellDelegate?.bidButtonTouchUpInside(cell: self)
  }
  
  func addTargetToBidButton(){
    bidButton.addTarget(self, action: #selector(bidButtonTouchUpInsideAction(_:)), for: .touchUpInside)
  }
  
  func showPriceLabel(){
    biddingLabel.isHidden = false
    bidButton.isHidden = true
  }
  
  func showBidButton(){
    biddingLabel.isHidden = true
    bidButton.isHidden = false
  }
  
}
