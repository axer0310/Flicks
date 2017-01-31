//
//  MovieViewController.swift
//  Flicks
//
//  Created by Arthur on 2017/1/30.
//  Copyright © 2017年 Kuan-Ting Wu (Arthur Wu). All rights reserved.
//

import UIKit

class MovieViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{

    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self;
        tableView.delegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 20;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath);
        
        cell.textLabel!.text = "row \(indexPath)";
        print("row \(indexPath)")
        
        
        return cell;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
