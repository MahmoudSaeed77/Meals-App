//
//  AddProductViewController.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import UIKit
protocol GoToHomeDelegate {
    func instatiateHomeViewController()
}
class AddProductViewController: UIViewController {
    
    // MARK:- outelets
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var infoField: UITextField!
    @IBOutlet weak var mealField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var collectionWidth: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var doneBtn: AppButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var addImgBtn: UIButton!
    
    // MARK:- Variables
    var viewModel: AddProductViewModel!
    var delegate: GoToHomeDelegate? = nil
    var type: AddOption?
    var imagePicker = UIImagePickerController()
    var images = [UIImage]()
    var dataContainer = [String]()
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = AddProductViewModel(view: self)
        self.UI()
        self.handleKeyboard()
        self.configureCollection()
        self.selectableFieldsUI()
        self.setupDelegates()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK:- UI Functions
    fileprivate func UI() {
        self.hideKeyboardWhenTappedAround()
        self.doneBtn.dropShadow()
        self.addImgBtn.dropViewShadow()
        if self.type == .fromHome {self.backBtn.isEnabled = false}
    }
    fileprivate func handleKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    private func setupDelegates() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    private func selectableFieldsUI() {
        self.mealField.text = self.viewModel.mealData[0]
        self.typeField.text = self.viewModel.typeData[0]
    }
    
    private func configureCollection() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
    }
    private func resetView() {
        self.images.removeAll()
        self.imagesCollectionView.reloadData()
        self.selectableFieldsUI()
        self.nameField.text = ""
        self.infoField.text = ""
        self.priceField.text = ""
    }
    private func imgAction() {
        // upload new image
        
        let alert = UIAlertController(title: "Chose type", message: "", preferredStyle: .actionSheet)
        
        let saved = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            self.imagePicker.sourceType = .savedPhotosAlbum
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.alert(success: false, withImage: true, message: "Camera not found", completion: {})
                return
            }
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let library = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(saved)
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func choseMeal() {
        self.pickerContainerView.isHidden = false
        self.dataContainer = self.viewModel.mealData
        self.viewModel.isMealSelected = true
        self.pickerView.reloadAllComponents()
    }
    
    private func choseType() {
        self.pickerContainerView.isHidden = false
        self.viewModel.isMealSelected = false
        self.dataContainer = self.viewModel.typeData
        self.pickerView.reloadAllComponents()
    }
    
    // MARK:- Actions
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    @objc func deleteImgAction(sender: UIButton) {
        self.images.remove(at: sender.tag)
        self.imagesCollectionView.reloadData()
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addimagesAction(_ sender: UIButton) {
        self.imgAction()
    }
    @IBAction func doneAction(_ sender: UIButton) {
        
        guard !self.images.isEmpty else {
            self.alert(success: false, withImage: true, message: "Images required", completion: {})
            return
        }
        guard !self.nameField.text!.isEmpty else {
            self.alert(success: false, withImage: true, message: "Name field required", completion: {})
            return
        }
        guard !self.infoField.text!.isEmpty else {
            self.alert(success: false, withImage: true, message: "Info field required", completion: {})
            return
        }
        guard !self.priceField.text!.isEmpty else {
            self.alert(success: false, withImage: true, message: "Price field required", completion: {})
            return
        }
        self.doneBtn.indicator.startAnimating()
        let userId = UserDefaults.standard.value(forKey: "userId") as? Int ?? 0
        let image = self.images.first?.jpegData(compressionQuality: 1)
        self.viewModel.localData.addProduct(userId: Int(userId), productId: Int(arc4random()), image: image! as NSData, info: self.infoField.text ?? "", meal: self.mealField.text ?? "", name: self.nameField.text ?? "", price: self.priceField.text ?? "", type: self.typeField.text ?? "") { _ in
            self.alert(success: true, withImage: true, message: "product added successfully") {
                
                let alert = UIAlertController(title: "Note", message: "Do you want to add another meal", preferredStyle: .alert)
                let agree = UIAlertAction(title: "Agree", style: .default) { action in
                    self.resetView()
                }
                let cancel = UIAlertAction(title: "Disagree", style: .destructive) { _ in
                    alert.dismiss(animated: true) {
                        self.resetView()
                        if self.delegate != nil {
                            self.delegate?.instatiateHomeViewController()
                        }
                    }
                }
                alert.addAction(cancel)
                alert.addAction(agree)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        self.doneBtn.indicator.stopAnimating()
    }
    @IBAction func mealPlus(_ sender: UIButton) {
        self.choseMeal()
    }
    @IBAction func mealMinus(_ sender: UIButton) {
        self.choseMeal()
    }
    @IBAction func typePlus(_ sender: UIButton) {
        self.choseType()
    }
    @IBAction func typeMinus(_ sender: UIButton) {
        self.choseType()
    }
    @IBAction func pricePlus(_ sender: UIButton) {
    }
    @IBAction func priceMinus(_ sender: UIButton) {
    }
    @IBAction func dismissAction(_ sender: UIButton) {
        self.pickerContainerView.isHidden = true
    }
}
