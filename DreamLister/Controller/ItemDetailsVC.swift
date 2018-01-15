//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Mirel Spahić on 1/14/18.
//  Copyright © 2018 Mirel Spahić. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var thumImg: UIImageView!
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    
    var stores = [Store]()
    var imagePicker: UIImagePickerController!
    
    var itemToEdit: Item?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        self.storePicker.delegate = self
        self.storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        //createStores()
        
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    func createStores(){
        let store1 = Store(context: context)
        store1.name = "Best buy"
        
        let store2 = Store(context: context)
        store2.name = "Tesla Dealership"
        
        let store3 = Store(context: context)
        store3.name = "Frys Electronics"
        
        let store4 = Store(context: context)
        store4.name = "Target"
        
        let store5 = Store(context: context)
        store5.name = "Amazon"
        
        let store6 = Store(context: context)
        store6.name = "K Mart"
        
        ad.saveContext()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func getStores(){
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do{
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }catch {
            //handle the error
        }
    }
    @IBAction func savePressed(_ sender: UIButton) {
        var item: Item!
        let picture = Picture(context: context)
        picture.image = thumImg.image
        
        if (itemToEdit == nil){
            item = Item(context: context)
        }else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func loadItemData(){
        
        if let item = itemToEdit{
            titleField.text = item.title
            detailsField.text = item.details
            priceField.text = "\(item.price)"
            thumImg.image = item.toImage?.image as? UIImage
            if let store = item.toStore {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    
                    index += 1
                } while (index < stores.count)
            }
        }
        
    }

    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
             navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            thumImg.image = image
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
