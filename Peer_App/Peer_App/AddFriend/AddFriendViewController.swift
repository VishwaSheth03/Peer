//
//  AddFriendViewController.swift
//  Peer_App
//
//  Created by Vishwa Sheth on 2018-02-24.
//  Copyright © 2018 Vishwa Sheth. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    @IBOutlet weak var friendNameLabel: UILabel!
    
    var friendName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendNameLabel.text = friendName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func customInit(friendName: String){
        self.friendName = friendName
    }

}
