//
//  MasterViewController.swift
//  RIP
//
//  Created by Brian Hill on 11/22/16.
//  Copyright © 2016 cs197. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Member]()
    var endpointURL: URL = URL(string: "http://localhost:8080/product/0767026128/reviews")!

    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
       // self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        DispatchQueue.global().async {
            self.activityIndicator.startAnimating()
            self.parseJSON()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        
        //parseJSON()
        
        
        //objects.append("076780192X")
    }
    func parseJSON(){
        print("parsing json")
        let task = URLSession.shared.dataTask(with: endpointURL, completionHandler:{
            (data, response, error) -> Void in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            print(statusCode)
            if statusCode == 200{
                do{
                    let json  = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    if let membersDict = json as? [String: Any]{
                        let members = membersDict["reviews"] as? [[String: Any]]
                        for member in members!{
                            let productId = member["product_id"] as! String
                            let summary = member["summary"] as! String
                            let rating = member["rating"] as! Int
                            let text = member["text"] as! String
                            
                            var memberClass = Member(product_id: productId, summary: summary, rating: rating, text: text)
                            print(memberClass.summary)
                            self.objects.append(memberClass)
                            //print(self.objects.summary)
                        }
                        self.tableView.reloadData()
                    }
                    self.activityIndicator.stopAnimating()
                    
                }
                catch{
                    print("error with JSON")
                }
            }
        })
        task.resume()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func insertNewObject(_ sender: Any) {
//        //objects.insert(NSDate(), at: 0)
//        let indexPath = IndexPath(row: 0, section: 0)
//        self.tableView.insertRows(at: [indexPath], with: .automatic)
//    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! Member
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object.text
                controller.product = object.product_id
                controller.ratingOf = object.rating
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] as! Member
        cell.textLabel!.text = object.summary
        print(object.summary)
        print("cell")
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

