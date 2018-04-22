//
//  HomeTableViewController.swift
//  Instagram
//
//

import UIKit
import Firebase
import FirebaseDatabase


class HomeTableViewController: UITableViewController {

    var temp = [photoModel]()
    var photos = [photoModel]()
    var refreshControla: UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    let myImage = UIImageView(frame: CGRect(x: view.center.x, y: 0, width: 50, height: 50))
        
          navigationController?.navigationItem.titleView = myImage
        
        
        refreshControla = UIRefreshControl()
        

        refreshControla.addTarget(self, action: #selector( callToRefresh(_:)), for: UIControlEvents.valueChanged)
        
        tableView.insertSubview(refreshControla, at: 0)
        
        navigationController?.navigationBar.topItem?.title = "Instagram"

        
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        populateWithUrl()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        let h1 = tabBarController?.tabBar.frame.height ?? CGFloat(0)
        let h2 = navigationController?.navigationBar.frame.height ?? CGFloat(0)

        return view.frame.height - h1 - h2 
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell

        // Configure the cell...
        
        cell.imageUrl = photos[indexPath.row].photoUrl
        cell.descr = photos[indexPath.row].description
        cell.avatarUrl = photos[indexPath.row].avatarUrl
        cell.name = photos[indexPath.row].name
        
        cell.timeStamp =  photos[indexPath.row].timeStamp
        
        return cell
        
    }
    
    
    func populateWithUrl(){
        
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        
        ref.child("photos").observeSingleEvent(of: .value, with: {(snapshot) in
            for child in snapshot.children {
                let child1 = child as? DataSnapshot
                let photos = child1?.value as? NSDictionary
                
                
                let photosUrl = photos?.value(forKey: "photo") as? String
                
                let descr = photos?.value(forKey: "Description") as? String
                
                let id = photos?.value(forKey: "name") as? String
                
                let stamp = photos?.value(forKey: "timestamp") as? TimeInterval
                
                
                if let photosUrl  = photosUrl {
                    
                    
                    if let id = id {
                    ref.child("users").child(id).observeSingleEvent(of: .value, with: {(snapshot) in
                        let info = snapshot.value as? NSDictionary
                        
                        
                        let avatarUrl = info?.value(forKey: "userPhoto") as? String
                        let name = info?.value(forKey: "username") as? String
                        
                        var classy = photoModel()
                        classy.avatarUrl = avatarUrl
                        classy.description = descr
                        classy.photoUrl = photosUrl
                        classy.name = name
                        classy.timeStamp = stamp
                        self.photos.insert(classy, at: 0)

                        self.tableView.reloadData()
                        self.refreshControla.endRefreshing()

                        })
                    }
                    
                   
                    
            //    self.photosArray.insert(photosUrl!, at: 0)
                
                
                }
               
            }

      

            

            
        }
            
        )
        
        
    }
    @objc func callToRefresh(_ refreshControl: UIRefreshControl) {
        self.photos = []
        populateWithUrl()
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
