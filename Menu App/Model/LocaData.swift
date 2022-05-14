//
//  LocaData.swift
//  Menu App
//
//  Created by Mohamed Ibrahem on 30/04/2022.
//

import Foundation
import CoreData

class LocaData {
    static var successMessage:String?
    
    @available(iOS 13.0, *)
    func fetchUserData(compilition: ([User])->Void){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do{
            let result = try context.fetch(request)
            compilition(result as! [User])
        }catch{
            
        }
    }
    
    
    
    @available(iOS 13.0, *)
    func saveUserData(id: Int, username: String, password: String, compilition: (Bool) -> Void) {
        
        let new_Save = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        new_Save.setValue(id, forKey: "id")
        new_Save.setValue(username, forKey: "username")
        new_Save.setValue(password, forKey: "password")
        LocaData.successMessage = {
            return "user added"
        }()
        do{
            app_del.saveContext()
            compilition(true)
        } catch let err {
            print(err.localizedDescription)
        }
        
    }
    
    @available(iOS 13.0, *)
    func addProduct(userId: Int, productId: Int, image: NSData, info: String, meal: String, name: String, price: String, type: String, compilition: (Bool) -> Void) {
        
        let new_Save = NSEntityDescription.insertNewObject(forEntityName: "Products", into: context)
        
        new_Save.setValue(userId, forKey: "userId")
        new_Save.setValue(productId, forKey: "productId")
        new_Save.setValue(image, forKey: "image")
        new_Save.setValue(info, forKey: "info")
        new_Save.setValue(meal, forKey: "meal")
        new_Save.setValue(name, forKey: "name")
        new_Save.setValue(price, forKey: "price")
        new_Save.setValue(type, forKey: "type")
        
        LocaData.successMessage = {
            return "user added"
        }()
        do{
            app_del.saveContext()
            compilition(true)
        } catch let err {
            print(err.localizedDescription)
        }
        
    }
    
    @available(iOS 13.0, *)
    func fetchProductsData(compilition: ([Products])->Void){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")
        
        do{
            let result = try context.fetch(request)
            compilition(result as! [Products])
        }catch{
            
        }
    }
    
    //    @available(iOS 13.0, *)
    //    func update(count:Int,id:String, compilition: (()->())){
    //
    //        self.fetch_Cart_data { (list) in
    //
    //            for item in list {
    //                if id == item.id{
    //                    item.count = Int16(count)
    //                }
    //            }
    //
    //            do{
    //                app_del.saveContext()
    //                print("saved")
    //            }catch{
    //
    //            }
    //
    //            compilition()
    //        }
    //    }
    
    
    //delete section
    //    @available(iOS 13.0, *)
    //    func delete_all(){
    //        self.fetch_Cart_data { (list) in
    //            print("list -> ",list)
    //            for item in list{
    //                context.delete(item)
    //            }
    //            do{
    //                app_del.saveContext()
    //                print("saved")
    //            }
    //
    //        }
    //    }
    
    
    //    @available(iOS 13.0, *)
    //    func delete_items(itemsID: String, compilition: (Bool)->Void){
    //        self.fetch_Cart_data { (list) in
    //
    //            for var index in 0..<list.count{
    //                if itemsID == list[index].id ?? "0"{
    //                    context.delete(list[index])
    //                    break
    //                }
    //                index+=1
    //            }
    //
    //            do{
    //                app_del.saveContext()
    //                compilition(true)
    //                print("saved")
    //            }catch{
    //                compilition(false)
    //            }
    //        }
    //    }
}
