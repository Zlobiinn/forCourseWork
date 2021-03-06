//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Петр Злобин on 22.02.2021.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {
        
    //MARK: Main
    
    private lazy var store = HabitsStore.shared
    
    weak var habitsViewControllerDelagate: CreateCellDelegate?
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var colorButton: UIButton!
    
    @IBOutlet weak var deleteHabit: UIButton!
    
    @IBOutlet weak var nameOfHabit: UITextField!
    
    @IBOutlet weak var dataPickerLabel: UITextView!
    
    @IBOutlet weak var dataPickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataPickerView.datePickerMode = .time
        dataPickerLabel.text = dateFormatter.string(from: dataPickerView.date)
        dataPickerView.addTarget(self, action: #selector(dateChange(dataPickerView:)), for: .valueChanged)
        view.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: For DatePicker
    
    @IBAction func dataChange(_ sender: UIDatePicker) {
        dataPickerLabel.text = dataPickerView.date.description
    }
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector (viewTapped(gestureRecognizer:)))
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter
    }()
    
    @objc func viewTapped(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChange (dataPickerView: UIDatePicker) {
        dataPickerLabel.text = dateFormatter.string(from: dataPickerView.date)
        view.endEditing(true)
    }
    
    //MARK: For Color Button
    
    @IBAction func ChangeColorButton(_ sender: UIButton) {
        presentColorPicker()
    }
    
    let colorPicker = UIColorPickerViewController()
    
    func presentColorPicker() {
        colorPicker.delegate = self
        colorPicker.selectedColor = colorButton.currentTitleColor
        colorPicker.title = "Выберите цвет наименования"
        present(colorPicker, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.tintColor = colorPicker.selectedColor
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorButton.tintColor = colorPicker.selectedColor
    }
    
    //MARK: Save Button & Cancel Button
    
    @IBAction func cancelButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard nameOfHabit.text == "Бегать по утрам, спать 8 часов и тп." else {
            nameOfHabit.placeholder = "Заполните наименование привычки"
            return
        }
        guard nameOfHabit.text!.isEmpty && dataPickerView.date.description.isEmpty == false
        else {
            return
        }
        
        HabitsViewController.newHabitEmptyBlock = Habit(name: nameOfHabit.text!,
                                                        date: dataPickerView.date,
                                                        color: colorButton.currentTitleColor)
        
        habitsViewControllerDelagate?.addNewCell()
        store.habits.append(HabitsViewController.newHabitEmptyBlock)
        self.dismiss(animated: true, completion: nil)
    }
}
