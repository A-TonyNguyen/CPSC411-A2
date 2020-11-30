//
//  ViewGenerator.swift
//  CPSC411_A2
//
//  Created by Tony Nguyen on 11/20/20.
//

import UIKit

class ViewGenerator
{
    var root : UIView!
    var values : [UITextField]!
    var sendButton : UIButton!
    var completeStackView : UIStackView!
    
    init(view : UIView)
    {
        root = view
    }
    
    func setViewReference()
    {
        values = [UITextField]()
        
        for sv in completeStackView.arrangedSubviews
        {
            if sv is UILabel
            {
                continue
            }
            
            let innerStackView = sv as! UIStackView
            
            for ve in innerStackView.arrangedSubviews
            {
                if ve is UITextField
                {
                    values.append(ve as! UITextField)
                }
                
                if ve is UIButton
                {
                    let button = ve as! UIButton
                    
                    if button.titleLabel?.text == "Add"
                    {
                        sendButton = button
                    }
                }
            }
        }
    }

    func generate()
    {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        
        let lblTitle = UILabel()
        lblTitle.font = UIFont.boldSystemFont(ofSize: 25.0)
        lblTitle.text = "Please Enter Claim Information"
        lblTitle.textAlignment = .center
        lblTitle.sizeToFit()
        stackView.addArrangedSubview(lblTitle)
        
        var fieldValueGenerator : FieldValueViewGenerator!
        var sView : UIStackView!
        
        //For Claim Title
        fieldValueGenerator = FieldValueViewGenerator(name:"  Claim Title:", val: " Enter Title")
        sView = fieldValueGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        //For Date
        fieldValueGenerator = FieldValueViewGenerator(name:"  Date:", val: " Enter Date: mm/dd/yyyy")
        sView = fieldValueGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        //For Add Button
        let btnGenerator = ButtonViewGenerator(name: "Add")
        sView = btnGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        //For Status
        fieldValueGenerator = FieldValueViewGenerator(name:"  Status:", val: " Waiting for User Input...", readOnly: true)
        sView = fieldValueGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        completeStackView = stackView
        root.addSubview(stackView)
        
        setViewReference()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let sv1 = stackView.topAnchor.constraint(equalTo: root.safeAreaLayoutGuide.topAnchor)
        let sv2 = stackView.leadingAnchor.constraint(equalTo: root.safeAreaLayoutGuide.leadingAnchor)
        let sv3 = stackView.bottomAnchor.constraint(equalTo: root.safeAreaLayoutGuide.bottomAnchor)
        let sv4 = stackView.trailingAnchor.constraint(equalTo: root.safeAreaLayoutGuide.trailingAnchor)
        
        sv1.isActive = true
        sv2.isActive = true
        sv3.isActive = false
        sv4.isActive = true
    }
}

class ButtonViewGenerator
{
    var lblName : String!
    
    init(name : String)
    {
        lblName = name
    }
    
    func generate() -> UIStackView
    {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
       
        let button = UIButton()
        button.setTitle(lblName, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.systemRed

        stackView.addArrangedSubview(button)
        
        return stackView
    }
}

class FieldValueViewGenerator
{
    var lblName : String!
    var initValue : String!
    var readOnlyState : Bool!
    
    init(name : String, val : String = "Initial Value", readOnly : Bool = false)
    {
        lblName = name
        initValue = val
        readOnlyState = readOnly
    }
    
    func generate() -> UIStackView
    {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.backgroundColor = UIColor.systemGray6
        //
        let lbl = UILabel()
        lbl.text = lblName
        lbl.sizeToFit()
        stackView.addArrangedSubview(lbl)
        
        let val = UITextField()
        val.text = initValue
        val.backgroundColor = UIColor.systemGray4
        stackView.addArrangedSubview(val)
        
        if (readOnlyState)
        {
            val.isUserInteractionEnabled = false
        }
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        
        lbl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        val.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return stackView
    }
}
