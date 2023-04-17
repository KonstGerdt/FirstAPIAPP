//
//  ViewController.swift
//  FirstAPIAPP
//
//  Created by Konstantin Durkin on 17.04.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let url = URL(string: "http://www.boredapi.com/api/activity/")!

        let request = URLRequest(url: url)

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Error: No data returned")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    if let activity = json["activity"] as? String,
                       let type = json["type"] as? String,
                       let participants = json["participants"] as? Int {
                        print("Activity: \(activity)")
                        print("Type: \(type)")
                        print("Participants: \(participants)")
                    } else {
                        print("Error: Invalid JSON format")
                    }
                } else {
                    print("Error: Invalid JSON format")
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}
