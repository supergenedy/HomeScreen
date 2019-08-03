//
//  HomeViewController.swift
//  HomeScreen
//
//  Created by Ahmed on 8/3/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit
import FanMenu
import SwiftyJSON

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calenderBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bellBtn: UIButton!
    
    @IBOutlet weak var fanMenu: FanMenu!
    
    
    var hotSpots = [ListItem]()
    var events = [ListItem]()
    var attractions = [ListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.leftViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let img = UIImage(named: "location_search_icon")
        imgView.image = img
        searchTextField.leftView = imgView
        
        searchTextField.rightViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "filter_inside_search")
        imageView.image = image
        searchTextField.rightView = imageView
        
        
        // distance between button and items
        fanMenu.menuRadius = 100.0

        // animation duration
        fanMenu.duration = 0.35

        // menu background color
        fanMenu.menuBackground = .white

        
        
        fanMenu.button = FanMenuButton(
            id: "1",
            image: nil,
            color: .clear
        )

        fanMenu.items = [
            FanMenuButton(
                id: "map",
                image: "small_grey_location_pin",
                color: .silver,
                title: "Map",
                titleColor: .black,
                titlePosition: .bottom
            ),
            FanMenuButton(
                id: "0",
                image: nil,
                color: .clear
            ),
            FanMenuButton(
                id: "0",
                image: nil,
                color: .clear
            ),
            FanMenuButton(
                id: "hotspot",
                image: "hotspot_icon",
                color: .silver,
                title: "HotSpotS",
                titleColor: .black,
                titlePosition: .bottom
            ),FanMenuButton(
                id: "attarctions",
                image: "attarctions_icon",
                color: .silver,
                title: "Attarctions",
                titleColor: .black,
                titlePosition: .bottom
            ),
            FanMenuButton(
                id: "events",
                image: "events_icon",
                color: .silver,
                title: "Events",
                titleColor: .black,
                titlePosition: .bottom
            )
        ]
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getHomeData()
    }
    
    func getHomeData(){
        ApiClient().callHomeAPI { result in
            if result == nil {
                print("error")
            }else {
                var json = result
                
                self.hotSpots.removeAll()
                self.attractions.removeAll()
                self.events.removeAll()
                
                for i in 0..<json!["data"]["hot_spots"].count {
                    self.hotSpots.append(ListItem(
                        name: json!["data"]["hot_spots"][i]["name"].string,
                        category: json!["data"]["hot_spots"][i]["categories"][0]["name"].string,
                        photo: json!["data"]["hot_spots"][i]["photos"][0].string))
                }
                for i in 0..<json!["data"]["attractions"].count {
                    self.attractions.append(ListItem(
                        name: json!["data"]["attractions"][i]["name"].string,
                        category: json!["data"]["attractions"][i]["categories"][0]["name"].string,
                        photo: json!["data"]["attractions"][i]["photos"][0].string))
                }
                for i in 0..<json!["data"]["events"].count {
                    self.events.append(ListItem(
                        name: json!["data"]["events"][i]["name"].string,
                        category: json!["data"]["events"][i]["categories"][0]["name"].string,
                        photo: json!["data"]["events"][i]["photos"][0].string))
                }
                self.tableView.reloadData()
            }
        }
    }
    

    @IBAction func bellClick(_ sender: Any) {
        if self.fanMenu.isOpen {
            self.fanMenu.isHidden = true
            self.fanMenu.close()
        }else {
            self.fanMenu.isHidden = false
            self.fanMenu.open()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        tableCell.collectionView.delegate = self
        tableCell.collectionView.dataSource = self
        tableCell.collectionView.tag = indexPath.row
        tableCell.collectionView.reloadData()
        
        return tableCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return hotSpots.count
        }else if collectionView.tag == 1 {
            return events.count
        }else if collectionView.tag == 2 {
            return attractions.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        
        if collectionView.tag == 0 {
            cell.loadImage(urlString: hotSpots[indexPath.row].photo)
            cell.title.text = hotSpots[indexPath.row].name
            cell.subtitle.text = hotSpots[indexPath.row].category
        } else if collectionView.tag == 1 {
            cell.loadImage(urlString: events[indexPath.row].photo)
            cell.title.text = events[indexPath.row].name
            cell.subtitle.text = events[indexPath.row].category
        } else if collectionView.tag == 2 {
            cell.loadImage(urlString: attractions[indexPath.row].photo)
            cell.title.text = attractions[indexPath.row].name
            cell.subtitle.text = attractions[indexPath.row].category
        }
        return cell
    }
    
    
    
}
