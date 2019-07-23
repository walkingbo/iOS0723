//
//  ViewController.swift
//  iOS0723
//
//  Created by 503_18 on 23/07/2019.
//  Copyright © 2019 503_18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //테이블 뷰에 출력할 데이터 배열
    var ar:[String]!
    var images:[String]!
    var skills:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "소녀시대"
        //배열에 데이터 생성
        ar = ["제시카","태연","유리","써니"]
        images = ["image1.png","image2.png","image3.png","image4.png"]
        skills = ["노래","중국어","춤","연기"]
        //테이블 뷰 출력을 위한 DataSource와 Delegate 설정
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension ViewController:UITableViewDataSource, UITableViewDelegate{
    
    //셀을 선택했을 때 호출되는 메소드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let selectedItem = ar[indexPath.row];
        var alert = UIAlertController(title: "소녀시대", message: selectedItem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert,animated: true)
    }
    
    
    //섹션의 개수를 설정하는 메소드
    func numberOfSections(in tableView:UITableView)->Int{
        return 1
    }
    //섹션 별 행의 개수를 설정하는 메소드
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int)->Int{
        return ar.count
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath)->UITableViewCell{
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if(cell == nil){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        //배열에서 행번호에 해당하는 데이터를 textLabel에 출력
        cell!.textLabel!.text = ar[indexPath.row]
        cell!.imageView!.image = UIImage(named: images[indexPath.row])
        cell!.detailTextLabel?.text = skills[indexPath.row]
        return cell!
    }

}
