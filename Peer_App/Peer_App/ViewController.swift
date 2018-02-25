//
//  ViewController.swift
//  Peer_App
//
//  Created by Vishwa Sheth on 2018-02-08.
//  Copyright © 2018 Vishwa Sheth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Constants and Variables
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var daysOfMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    var currentMonth = String()
    
    var classArr = ["BIO101", "Chemistry"]
    var friendsArr = ["Vishwa", "Yash", "Siddharth", "Jay"]
    
    var username = "VishwaSheth"
    var password = "HelloWorld"
    
    var menuShowing = false
    
    var addFriendTextField: UITextField?
    
    //MARK: Objects
    
        //Login View
    
        //Calendar View
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var addFriendsButton: UIBarButtonItem!
    @IBOutlet weak var sideMenuView: UIView!
    
    //Class List View
    @IBOutlet weak var classTableView: UITableView!
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var addClassButton: UIButton!
    
        //Add Class View
    
    //MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = months[month]
        
        //monthLabel.text = "\(currentMonth) \(year)"
    }
    
    func addFriendTextField(textField: UITextField!)
    {
        addFriendTextField = textField
        addFriendTextField?.placeholder = "New Friend"
    }
    
    func addHandler(alert: UIAlertAction!)
    {
        let addFriendButton = AddFriendViewController()
        addFriendButton.customInit(friendName: (addFriendTextField?.text)!)
        addFriend()
    }
    
    //FIX!!!!!!
    func addFriend()
    {
        friendsArr.append((addFriendTextField?.text!)!)
        
        let indexPath = IndexPath(row: friendsArr.count - 1, section: 0)
        
        friendsTableView.beginUpdates()
        friendsTableView.insertRows(at: [indexPath], with: .automatic)
        friendsTableView.endUpdates()
        
        view.endEditing(true)
    }
    
    
    func addClass()
    {
        classArr.append(classTextField.text! + " " + timeTextField.text!)
        
        let indexPath = IndexPath(row: classArr.count - 1, section: 0)
        
        classTableView.beginUpdates()
        classTableView.insertRows(at: [indexPath], with: .automatic)
        classTableView.endUpdates()
        
        classTextField.text = ""
        view.endEditing(true)
    }
    
    //MARK: Actions
    
        //Add class button is clicked
    @IBAction func addClassButtonClicked(_ sender: Any) {
        addClass()
    }
    
    @IBAction func sideMenuButtonClicked(_ sender: Any) {
        if (menuShowing){
            sideMenuLeadingConstraint.constant = -200
        }
        else{
            sideMenuLeadingConstraint.constant = 0
            UIView.animate(withDuration: 0.5, animations: {self.view.layoutIfNeeded()})
            view.bringSubview(toFront: sideMenuView)
        }
        menuShowing = !menuShowing
    }
    
        //Add friend button is clicked
    @IBAction func addFriendButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "New Friend", message: nil, preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: addFriendTextField)
        
        let addHandler = UIAlertAction(title: "Add", style: .default, handler: self.addHandler)
        
        alertController.addAction(addHandler)
        
        self.present(alertController, animated: true)
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        switch currentMonth{
        case "December":
            month = 0
            year += 1
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calendarCollectionView.reloadData()
            
        default:
            month += 1
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calendarCollectionView.reloadData()
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        switch currentMonth{
        case "January":
            month = 11
            year -= 1
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calendarCollectionView.reloadData()
            
        default:
            month -= 1
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calendarCollectionView.reloadData()
        }
    }
    
}


//************************************************EXTENSION************************************************//
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (tableView == classTableView){
            return(classArr.count)
        }
        else{
            return(friendsArr.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (tableView == classTableView){
            let prototypeCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "prototypeCell")
            
            prototypeCell.textLabel?.text = classArr[indexPath.row]
            
            return(prototypeCell)
        }
        else{
            let friendsCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "friendsCell")
            
            friendsCell.textLabel?.text = friendsArr[indexPath.row]
            
            return(friendsCell)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if (tableView == classTableView){
            if editingStyle == .delete
            {
                classArr.remove(at: indexPath.row)
                
                classTableView.beginUpdates()
                classTableView.deleteRows(at: [indexPath], with: .automatic)
                classTableView.endUpdates()
            }
        }
        else{
            if editingStyle == .delete
            {
                friendsArr.remove(at: indexPath.row)
                
                friendsTableView.beginUpdates()
                friendsTableView.deleteRows(at: [indexPath], with: .automatic)
                friendsTableView.endUpdates()
            }
        }
        
    }
    
}

//************************************************EXTENSION************************************************//
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysOfMonth[month]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.dateLabel.text = "\(indexPath.row + 1)"
        return cell
    }
    
}
