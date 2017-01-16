//
//  ViewController.swift
//  Dummy-Matrix-Client-Swift
//
//  Created by Avery Pierce on 1/16/17.
//  Copyright © 2017 Matrix. All rights reserved.
//

import UIKit
import MatrixSDK

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.text = "Loading..."
    
        // Load the public rooms on https://matrix.org
        let client = MXRestClient(homeServer: "https://matrix.org", andOnUnrecognizedCertificateBlock: nil)!
        let _ = client.publicRooms({ (objects) in
            
            self.textView.text = ""
            
            // Append a line in the text view for each room in the list.
            let rooms = (objects ?? []).flatMap({ return $0 as? MXPublicRoom })
            rooms.forEach { (room) in
                let roomName = room.name ?? "(null)"
                self.textView.text.append("\(roomName)\n")
            }
            
        }, failure: { (error) in
            guard let error = error else { return }
            print(error)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

