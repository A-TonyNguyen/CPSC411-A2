//
//  ViewController.swift
//  CPSC411_A2
//
//  Created by Tony Nguyen on 11/20/20.
//

import UIKit

class ViewController: UIViewController
{
    var cTitleField: UITextField?
    var cDateField: UITextField?
    var statusField: UITextField?
    
    //func to add a new claim data
    @objc func addData(sender: UIButton)
    {
        //initialize variables
        let cService = ClaimService(viewCon : self)
        let cTitle = cTitleField!.text
        let cDate = cDateField!.text
        
        //initialize obj
        let claimObj = Claim(title: cTitle!, date: cDate!)
        
        //add obj
        cService.addClaim(claim: claimObj)
        
        //sets obj data to blank
        cTitleField!.text = ""
        cDateField!.text = ""
    }
    
    //func to set status text field
    func setStatusTextField(status: String)
    {
        statusField!.text = status
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //1. Create Screen
        let screenGenerator = ViewGenerator(view: view)
        print("Screen generator is initialized. ")
        screenGenerator.generate()
        
        // 2. Prepare data
        let button = screenGenerator.sendButton
        cTitleField = screenGenerator.values[0]
        cDateField = screenGenerator.values[1]
        statusField = screenGenerator.values[2]
        
        // 3. Set the event handling
        button?.addTarget(self, action: #selector(addData(sender:)), for: .touchUpInside)
    }
    
}
