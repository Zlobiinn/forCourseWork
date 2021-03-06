//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Петр Злобин on 20.02.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    // MARK: Main
    
    var habitsViewControllerEmpty = HabitViewController()
    
    @IBOutlet weak var createButton: UIButton!
    
    static var newHabitEmptyBlock = Habit(name: "",
                                          date: .distantPast,
                                          color: .blue)
    
    @IBOutlet weak var mainTable: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        habitsViewControllerEmpty.habitsViewControllerDelagate = self
        mainTable.register(ViewCellProgress.setupNib(), forCellWithReuseIdentifier: "progressCell")
        mainTable.register(collectionViewCellMain.setupNib(), forCellWithReuseIdentifier: "cellMain")
        mainTable.backgroundColor = #colorLiteral(red: 0.9491037726, green: 0.9488252997, blue: 0.9661331773, alpha: 1)
    }
}

// MARK: tableChanges

extension HabitsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let progressCell = mainTable.dequeueReusableCell(withReuseIdentifier: "progressCell", for: indexPath) as! ViewCellProgress
        progressCell.layer.cornerRadius = 4
        progressCell.progressBar.progress = HabitsStore.shared.todayProgress
        progressCell.labelOfprogress.text = HabitsStore.shared.todayProgress.description
        return progressCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HabitsStore.shared.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reUsebleCell = mainTable.dequeueReusableCell(withReuseIdentifier: "cellMain", for: indexPath) as! collectionViewCellMain
        reUsebleCell.mainLabel.text = HabitsStore.shared.habits[indexPath.item].name
        reUsebleCell.everyDayAt.text = "Каждый день в"
        reUsebleCell.oneByOne.text = "Подряд"
        reUsebleCell.numberOfOneByOne.text = HabitsStore.shared.habits[indexPath.item].trackDates.description
        return reUsebleCell
    }
}

extension HabitsViewController: CreateCellDelegate {
    
    func addNewCell() {
        
        mainTable.reloadData()
        return
    }
}

extension HabitsViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32 , height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width - 32, height: 60)
        
    }
}
