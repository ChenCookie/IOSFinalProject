//
//  AddLoverTableViewController.swift
//  AddData
//
//  Created by SHIH-YING PAN on 22/12/2017.
//  Copyright © 2017 SHIH-YING PAN. All rights reserved.
//

import UIKit

class AddPictureTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var isChangeImage = false
    
    @IBOutlet weak var headButton: UIButton!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        isChangeImage = true
        
        headButton.setBackgroundImage(image, for: .normal)
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func changePhotoButtonPressed(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true, completion: nil)
        
    }
    var lover: Picture!
    
    @IBOutlet weak var innerBeautySwitch: UISwitch!
    
    @IBOutlet weak var starTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if numberSelect != -1 && decideSelect==true{
            lover=tempPicture
            starTextField.text=tempPicture.star
            nameTextField.text=tempPicture.name
            isChangeImage = true
            headButton.setBackgroundImage(tempPicture.image, for: .normal)
        }else{
            isChangeImage = true
            
            headButton.setBackgroundImage(getPic, for: .normal)
        }
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    func showAlert(message: String) {
        let controller = UIAlertController(title: "錯誤", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        guard let name = nameTextField.text, name.count > 0 else {
            
            showAlert(message: "請輸入名字")
            return false
        }
        
        guard let star = starTextField.text, star.count > 0 else {
            
            showAlert(message: "請輸入特性")

            return false
        }
        
   
        
        guard innerBeautySwitch.isOn else {
            showAlert(message: "不喜歡就不能新增!")
            return false
        }
        var imageName: String?
        if isChangeImage {
            imageName = "\(Date().timeIntervalSinceReferenceDate)"
            if let imageName = imageName {
                let url = Picture.documentsDirectory.appendingPathComponent(imageName)
                if let image = headButton.backgroundImage(for: .normal) {
                    let data = UIImageJPEGRepresentation(image, 0.9)
                    try? data?.write(to: url)
                }
            }
        }
            var calendar = Calendar.current
            calendar.locale = Locale.init(identifier: "zh_Hant_TW")
            print(calendar.timeZone)
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyy-MM-dd" //(格式可按自己需求修整)
            let strNowTime = timeFormatter.string(from: Date.init()) as String
            print(strNowTime)

        
        
        if numberSelect != -1 && decideSelect==true{
            lover.name=name
            lover.star=star
            lover.imageName=imageName
            lover.addDate=strNowTime
            
            pictures.remove(at: numberSelect)
            Picture.saveToFile(lovers: pictures)
            tableView.reloadData()
            
            
            return true
        }else{
            lover = Picture(name: name, star: star, innerBeauty: innerBeautySwitch.isOn, imageName: imageName,addDate:strNowTime)
            return true
        }
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
      
    }
    

}
