//
//  ViewController.swift
//  Calendar
//
//  Created by CHAK HO EROS YIP on 4/1/2018.
//  Copyright © 2018 EROS YIP. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate ,
    UICollectionViewDelegateFlowLayout

{

    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var currentYear =  Calendar.current.component(.year, from: Date())
    var currentMonth =  Calendar.current.component(.month, from: Date())
    var months = ["Janary","February","March","April","May","June","July","August","September","October","November","December"]
    var numberOfDaysInThisMonth:Int{
        let dateComponents = DateComponents(year:currentYear, month:currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        return range?.count ?? 0
    }
    
    var whatDayIsIt:Int{
        let dateComponents = DateComponents(year:currentYear, month:currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    
    var howManyItemsSouldIAdd:Int{
        return whatDayIsIt - 1
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
        currentMonth += 1
        if currentMonth == 13{
            currentMonth = 1
            currentYear += 1
        }
        setUp()
    }
    @IBAction func lastMonth(_ sender: UIButton) {
        currentMonth -= 1
        if currentMonth == 0{
            currentMonth = 12
            currentYear -= 1
        }
        setUp()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.blue]
        
        setUp()
        
    }

    func setUp(){
        timeLabel.text = months[currentMonth - 1] + "\(currentYear)"
        calendar.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInThisMonth + howManyItemsSouldIAdd
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let textLabel = cell.contentView.subviews[0] as? UILabel{
            if indexPath.row < howManyItemsSouldIAdd{
                textLabel.text = ""
            }
            else{
            textLabel.text = "\(indexPath.row + 1 - howManyItemsSouldIAdd)"
        }
        
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height:40)
        
        
    }
        
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendar.collectionViewLayout.invalidateLayout()
        calendar.reloadData()
        
    }
    
    
}






