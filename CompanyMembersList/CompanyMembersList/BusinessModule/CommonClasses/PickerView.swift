//
//  PickerView.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 20/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

class PickerView: NSObject {

    /// Local
    static let shared = PickerView()

    private var viewController = UIViewController()
    private var pickerView: UIPickerView?

    var pickerDataSource: [String]?
    private var completion : ((_ selectedIndex: Int, _ selectedData: String) -> Void)?
    private var selectedIndex: Int = 0
    let pickerHeight: CGFloat = 260.0
    let screenSize = UIScreen.main.bounds

    lazy var pickerUIView: UIView = {
        let picker = UIView(frame: CGRect(x: 0, y: screenSize.height - pickerHeight,
                                          width: screenSize.width, height: pickerHeight))
        return picker
    }()

    // MARK: -

    /// Display Picker View on UIViewController
    /// - Parameters:
    ///   - controller: Object of controller on which you need to an display Picker View.
    ///   - pickerArray: Pass your array of string for picker data
    ///   - completionBlock: You will get the call back here when user selected the data.
    func addPickerView(controller: UIViewController,
                       pickerArray: [String],
                       completion:@escaping ((_ selectedIndex: Int, _ selectedData: String) -> Void)) {

        pickerUIView = UIView(frame: CGRect(x: 0, y: screenSize.height - pickerHeight,
                                            width: screenSize.width, height: pickerHeight))

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0,
                                              width: controller.view.bounds.size.width, height: 44))

        let done = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneClick))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelClick))

        toolBar.setItems([cancel, flexSpace, done], animated: true)

        pickerUIView.addSubview(toolBar)

        pickerView = UIPickerView(frame: CGRect(x: 0, y: toolBar.frame.height,
                                                width: screenSize.width,
                                                height: pickerUIView.frame.height-toolBar.frame.height))
        pickerUIView.addSubview(pickerView!)

        pickerView?.backgroundColor = UIColor.white
        pickerView?.delegate = self
        pickerView?.dataSource = self
        viewController = controller
        pickerDataSource = pickerArray

        self.completion = completion

        viewController.view.addSubview(pickerUIView)
        hidePicker()
    }

    // MARK: - Action
    @objc func doneClick() {
        completion!(selectedIndex, (pickerDataSource?[selectedIndex] ?? ""))
        hidePicker()
    }

    @objc func cancelClick() {
        hidePicker()
    }

    // MARK: - Public
    func showPicker() {
        pickerView?.reloadAllComponents()
        showHidePicker(true)
    }
    func hidePicker() {
        showHidePicker(false)

    }

    // MARK: - Private
    private func showHidePicker(_ status: Bool) {
        if status == true {
            if self.pickerUIView.frame.origin.y == screenSize.height - self.pickerHeight {
                return
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.pickerUIView.frame.origin.y -= self.pickerHeight
            })

        } else {
            if self.pickerUIView.frame.origin.y == screenSize.height {
                return
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.pickerUIView.frame.origin.y += self.pickerHeight
            })
        }
    }
}

// MARK: - UIPickerViewDataSource
extension PickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (pickerDataSource?.count ?? 0)
    }

}

// MARK: - UIPickerViewDelegate
extension PickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource?[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
}
