//
//  ClaimService.swift
//  CPSC411_A2
//
//  Created by Tony Nguyen on 11/20/20.
//

import Foundation

struct Claim : Codable
{
    var title : String
    var date : String
    
    init(title: String, date: String)
    {
        self.title = title
        self.date = date
    }
}

class ClaimService
{
    init(viewCon : ViewController)
    {
        viewController = viewCon
    }
    
    var viewController : ViewController
    
    func addClaim(claim: Claim)
    {
        // Implement logic using Async HTTP client API (POST method)
        let requestUrl = "http://localhost:8020/ClaimService/add"
        var request = URLRequest(url: NSURL(string: requestUrl)! as URL)
        let jsonData : Data! = try! JSONEncoder().encode(claim)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) {
            (data, response, error) in
            if let resp = data
            {
                let respStr = String(bytes: resp, encoding: .utf8)
                print("The response data sent from the server is \(respStr!)")
                
                OperationQueue.main.addOperation
                {
                    self.viewController.setStatusTextField(status: "The Claim \(claim.title) was successfully created.")
                }
            }
            else if let respError = error
            {
                print("Server Error: \(respError)")
                OperationQueue.main.addOperation
                {
                    self.viewController.setStatusTextField(status: "The Claim: \(claim.title) was not created.")
                }
            }
        }
        task.resume()
    }
}
