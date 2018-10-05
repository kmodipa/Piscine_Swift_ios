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
        "http://s1.1zoom.me/b5457/460/Dogs_French_Bulldog_Colored_background_Glance_528929_3840x2160.jpg",
        "http://s1.1zoom.me/b6550/598/Dogs_French_Bulldog_Glance_532467_3840x2160.jpg",
        "http://s1.1zoom.me/b5957/459/Dogs_French_Bulldog_Puppy_Paws_529473_3840x2160.jpg",
        "http://s1.1zoom.me/b5353/964/French_Bulldog_Dogs_Puppy_527703_3840x2160.jpg",
        "http://s1.1zoom.me/b5457/460/Dogs_French_Bulldog_Colored_background_Glance_528929_3840x2160.jpg",
        "http://s1.1zoom.me/b6550/598/Dogs_French_Bulldog_Glance_532467_3840x2160.jpg",
        "http://s1.1zoom.me/b5957/459/Dogs_French_Bulldog_Puppy_Paws_529473_3840x2160.jpg",
        "http://s1.1zoom.me/b5353/964/French_Bulldog_Dogs_Puppy_527703_3840x2160.jpg",
    ]
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Setting the size */
        let itemSize = UIScreen.main.bounds.width/2 - 2
        
        /* A new LayOut to override our current layout */
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0) /*top, left, bottom, right*/
        layout.itemSize = CGSize(width: itemSize  , height: itemSize)
        
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        /* Connecting the new layout */
        myCollectionView.collectionViewLayout = layout
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
                imageCell.spinner.startAnimating()
                DispatchQueue.global().async {
                    let imageData = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        imageCell.myImageView.image = UIImage(data: imageData!)
                    }
                }
            }catch let err {
                print("Error: \(err.localizedDescription)")
            }
        }
        //imageCell.myImageView.image = UIImage(named: ImageArray[indexPath.row])
        
         return imageCell
    }
}

