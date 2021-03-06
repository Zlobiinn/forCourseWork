//
//  collectionViewCellProgress.swift
//  MyHabits
//
//  Created by Петр Злобин on 22.02.2021.
//

import UIKit

class ViewCellProgress: UICollectionViewCell {
        
    static func setupNib() -> UINib {
        return UINib(nibName: "viewCellProgress", bundle: nil)
    }
    
    @IBOutlet weak var labelOfprogress: UILabel!
    
    @IBOutlet weak var status: UILabel!
        
    @IBOutlet weak var progressBar: UIProgressView!
    
}
