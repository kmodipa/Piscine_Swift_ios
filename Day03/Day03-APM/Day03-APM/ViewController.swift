//
//  ViewController.swift
//  Day03-APM
//
//  Created by Khomotjo MODIPA on 2018/10/05.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    /* Data Source */
    let ImageArray:[String] = [
        "http://allhdwallpapers.com/wp-content/uploads/2017/05/French-Bulldog-2.jpg",
        "http://allhdwallpapers.com/wp-content/uploads/2017/05/French-Bulldog-6.jpg",
        "http://allhdwallpapers.com/wp-content/uploads/2017/05/French-Bulldog-5.jpg",
        "http://allhdwallpapers.com/wp-content/uploads/2017/05/French-Bulldog-4.jpg",
        "http://allhdwallpapers.com/wp-content/uploads/2017/05/French-Bulldog-1.jpg",
        "http://allhdwallpapers.com/wp-content/uploads/2017/05/French-Bulldog-3.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /* Number of Views */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageArray.count
    }
    
    /* Populate Views */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier:  "imageCell", for: indexPath) as! imageViewCellClass
        
        if let url = URL(string: ImageArray[indexPath.row])
        {
            do {
                let imageData = try Data(contentsOf: url)
                imageCell.myImageView.image = UIImage(data: imageData)
            }catch let err {
                print("Error: \(err.localizedDescription)")
            }
        }
        //imageCell.myImageView.image = UIImage(named: ImageArray[indexPath.row])
        
         return imageCell
    }
}

