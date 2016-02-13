//
//  MessageTableViewController.swift
//  ChatView
//
//  Created by Kapil Rathore on 12/02/16.
//  Copyright © 2016 Kapil Rathore. All rights reserved.
//

import UIKit

class MessageTableViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    
    var messageTitle = ["Hi am kapil"]
    var messageStatus = ["Sent"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func sendMessage(sender: AnyObject) {
        
        //add  data into table array from textField
        messageTitle.append(textField.text!)
        textField.text = ""
        messageStatus.append("Waiting")
        
        makeRequest()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //reload your tableView
            self.tableView.reloadData()
            
        })
        
        print(messageTitle)
        print(messageStatus)
        
        textField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageTitle.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell") as! MessageTableViewCell
        
        let row = indexPath.row
        
        cell.msgTitle2.text = messageTitle[row]
        cell.msgStatus2.text = messageStatus[row]
        
        return cell
    }
    
    func makeRequest() {
        
        let config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session: NSURLSession = NSURLSession(configuration: config)
        
        let urlPath: String = "https://www.google.co.in/"
        let url: NSURL = NSURL(string: urlPath)!
        let request1: NSURLRequest = NSURLRequest(URL: url)
        
        let dataTask = session.dataTaskWithRequest(request1) {
            (let data, let response, let error) in
            
            // 1. Check HTTP response for successful GET request
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    // 2. Create JSON object with data
                    do {
                        print("got request")
                        self.messageStatus[self.messageStatus.count - 1] = "Sent"
                        print(self.messageStatus)
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            //reload your tableView
                            self.tableView.beginUpdates()
                            let indexPath = NSIndexPath(forRow: self.messageStatus.count - 1, inSection: 0)
                            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Middle)
                            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Middle)
                            self.tableView.endUpdates()
                        })
                    }
                default:
                    print("request not successful.")
                }
            } else {
                print("Error: Not a valid HTTP response")
            }
        }
        
        dataTask.resume()
    }

}
