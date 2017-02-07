//
//  DescriptionViewController.swift
//  Flicks
//
//  Created by Arthur on 2017/2/6.
//  Copyright © 2017年 Kuan-Ting Wu (Arthur Wu). All rights reserved.
//

import UIKit
import AFNetworking

class DescriptionViewController: UIViewController {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    var movie: NSDictionary!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie["title"] as! String
        
        let baseURL = "https://image.tmdb.org/t/p/w500";
        if let posterPath = movie["poster_path"] as? String
        {
            var image = NSURL(string: baseURL+posterPath);
            posterImageView.setImageWith(image as! URL);
        }
        overviewLabel.text = movie["overview"] as! String
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
