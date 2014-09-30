//
//  LoginViewController.swift
//
//  Created by Hacktoolkit (@hacktoolkit) and Jonathan Tsai (@jontsai)
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignUp(sender: AnyObject) {
        var user = PFUser()
        var email = self.emailField.text
        var username = email
        var password = self.passwordField.text
        user.username = username
        user.password = password
        user.email = email
        // other fields can be set just like with PFObject
//        user["phone"] = "415-555-1212"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                println("Successfully signed up")
                self.performSegueWithIdentifier("loggedInSegue", sender: self)
            } else {
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            }
        }
    }

    @IBAction func onSignIn(sender: AnyObject) {
        var email = self.emailField.text
        var username = email
        var password = self.passwordField.text
        PFUser.logInWithUsernameInBackground(username, password:password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                println("successfully signed in")
                self.performSegueWithIdentifier("loggedInSegue", sender: self)
            } else {
                // The login failed. Check error to see why.
            }
        }
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
