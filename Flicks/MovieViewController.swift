//
//  MovieViewController.swift
//  Flicks
//
//  Created by Arthur on 2017/1/30.
//  Copyright © 2017年 Kuan-Ting Wu (Arthur Wu). All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MovieViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{

   
    
    @IBOutlet var tableView: UITableView!
    
    var endPoint:String!
    var movies : [NSDictionary]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self;
        tableView.delegate = self;
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if self.restorationIdentifier == "NowPlaying" ||
            self.restorationIdentifier == "NowPlaying1"{
            endPoint = "now_playing"
        } else {
            endPoint = "top_rated"
        }

        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endPoint!)?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print("*****************")
                    print(dataDictionary)
                    
                    
                    self.movies = dataDictionary["results"] as! [NSDictionary]
                    self.tableView.reloadData();
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
        
        }
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        task.resume()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let movies = movies
        {
            return movies.count;
        }
        else
        {
            return 0;
        }
        
        
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell;
        
        let movie = movies![indexPath.row];
        let title = movie["title"] as! String;
        let overview = movie["overview"] as! String;
        
        let baseURL = "https://image.tmdb.org/t/p/w500";
        if let posterPath = movie["poster_path"] as? String
        {
            var image = NSURL(string: baseURL+posterPath);
            cell.posterView.setImageWith(image as! URL);
        }
        
        
        
        cell.titleLabel.text = title;
        cell.overviewLabel.text = overview;
        
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
                    self.tableView.reloadData();
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movies![indexPath!.row]
        
        let descriptionView = segue.destination as! DescriptionViewController;
        descriptionView.movie = movie;
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
