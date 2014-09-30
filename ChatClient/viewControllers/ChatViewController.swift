//
//  ChatViewController.swift
//
//  Created by Hacktoolkit (@hacktoolkit) and Jonathan Tsai (@jontsai)
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    @IBOutlet weak var messageTableView: UITableView!

    var messages = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    func onTimer() {
        retrieveMessages()
    }

    func retrieveMessages() {
        // Do any additional setup after loading the view.
        var query = PFQuery(className:"Message")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) messages.")
                // Do something with the found objects
//                for object in objects {
//                    NSLog("%@", object.objectId)
//                }
                var messages = objects as [PFObject]
                self.messages = messages
                self.messageTableView.reloadData()
                var lastIndex = NSIndexPath(forRow: self.messages.count - 1, inSection: 0)
                self.messageTableView.scrollToRowAtIndexPath(lastIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(sender: AnyObject) {
        var messageText = self.messageField.text
        var message = PFObject(className: "Message")
        message["text"] = messageText
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if success {
                println("Message saved successfully")
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var messageCell = tableView.dequeueReusableCellWithIdentifier("messageCell") as MessageCell
        var message = self.messages[indexPath.row]
        messageCell.message = message
        return messageCell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
