//
//  collectionViewCellProgress.swift
//  MyHabits
//
//  Created by Петр Злобин on 21.02.2021.
//

import UIKit

class collectionViewCellMain: UICollectionViewCell {
   
    static func setupNib() -> UINib {
        return UINib(nibName: "viewCellMain", bundle: nil)
    }
    
    @IBOutlet weak var cirleButtomReady: UIButton!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var everyDayAt: UILabel!
    
    @IBOutlet weak var everyDayAtNumber: UILabel!
    
    @IBOutlet weak var oneByOne: UILabel!
    
    @IBOutlet weak var numberOfOneByOne: UILabel!
    
    static let identifier = "main"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        }
}
