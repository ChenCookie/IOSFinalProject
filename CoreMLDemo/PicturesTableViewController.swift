//
//  LoversTableViewController.swift
//  AddData
//
//  Created by SHIH-YING PAN on 22/12/2017.
//  Copyright © 2017 SHIH-YING PAN. All rights reserved.
//

import UIKit
var decideSelect:Bool!
var numberSelect:Int!
var tempPicture:Picture!
var pictures = [Picture]()
class PicturesTableViewController: UITableViewController {

    

    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //your code...
        numberSelect=indexPath.row
        tempPicture=pictures[indexPath.row]
        decideSelect=true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        pictures.remove(at: indexPath.row)
        Picture.saveToFile(lovers: pictures)
        tableView.reloadData()
        
    }
   
    
    @IBAction func goBackToLoversTableViewController(segue: UIStoryboardSegue) {
        if let controller = segue.source as? AddPictureTableViewController {
            pictures.append(controller.lover)
            Picture.saveToFile(lovers: pictures)
            tableView.reloadData()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberSelect = -1
        decideSelect = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
   
    
        if let ln = Picture.readLoversFromFile() {
            pictures = ln
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pictures.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath) as? PictureTableViewCell else  {
            assert(false)
        }

        // Configure the cell...
        let lover = pictures[indexPath.row]
        cell.nameLabel.text = lover.name
        cell.starLabel.text = lover.star
        cell.dateLabel.text=lover.addDate
        cell.headImageView.image = lover.image
        
        return cell
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let addLoverTableViewController = segue.destination as? AddPictureTableViewController, let row = tableView.indexPathForSelectedRow?.row
            else {
                return
                
        }
        addLoverTableViewController.lover = pictures[row]
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
