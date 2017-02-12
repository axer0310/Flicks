//
//  CollectionViewController.swift
//  Flicks
//
//  Created by Arthur on 2017/2/5.
//  Copyright © 2017年 Kuan-Ting Wu (Arthur Wu). All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate
{

    
    @IBOutlet var colection: UICollectionView!
    var movies : [NSDictionary]?
    var endPoint:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.restorationIdentifier == "NowPlaying" {
            endPoint = "now_playing"
        } else {
            endPoint = "top_rated"
        }
        colection.dataSource = self;
        colection.delegate = self;
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endPoint!)?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(dataDictionary)
                    self.movies = dataDictionary["results"] as! [NSDictionary]
                    self.colection.reloadData();
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
            
        }
        colection.reloadData();
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        colection.insertSubview(refreshControl, at: 0)
        task.resume()

        
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let cell = sender as? UICollectionViewCell
        {
        let indexPath = colection.indexPath(for: cell)
        let movie = movies![indexPath!.row]
        
        let descriptionView = segue.destination as! DescriptionViewController;
        descriptionView.movie = movie;
        
        }
        else if let cell = sender as? UIBarButtonItem
        {
            let listView = segue.destination as! MovieViewController;
            if(self.restorationIdentifier == "NowPlaying")
            {
                listView.endPoint = "now_playing";
            }
            else
            {
                listView.endPoint = "top_rated";

            }
        }
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

    // MARK: UICollectionViewDataSource



     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = movies
        {
            return movies.count;
        }
        else
        {
            return 0;
        }
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell;
    
            let movie = movies![indexPath.row];
        
        
        
            let baseURL = "https://image.tmdb.org/t/p/w500";
            var posterPath = movie["poster_path"] as!String;
        
            var image = NSURL(string: baseURL+posterPath);
        
            
            cell.posterView.setImageWith(image as! URL);
            return cell;

    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl)
    {
        
        // ... Create the URLRequest `myRequest` ...
        
        // Configure session so that completion handler is executed on main UI thread
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endPoint!)?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(dataDictionary)
                    self.movies = dataDictionary["results"] as! [NSDictionary]
                    self.colection.reloadData();
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
            
            
            
            // ... Use the new data to update the data source ...
            
            // Reload the tableView now that there is new data
            
            
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
        }
        task.resume()
    }

    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
