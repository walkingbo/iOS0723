
import UIKit
import SafariServices
class MyTableViewController: UITableViewController {
    //이름, 스킬, 이미지 파일명, url을 하나로 저장할 수 있는 자료형을 girl 이라는 이름으로 생성
    typealias girl = (name:String,skill:String,imageName:String, url:String)
    //girl의 배열을 생성
    var data = [girl]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "IU"
        data.append((name:"아이유1",skill:"노래",imageName:"iu1.jpg",url:"https://www.google.com"))
        data.append((name:"아이유2",skill:"연기",imageName:"iu2.jpeg",url:"http://www.naver.com"))
        data.append((name:"아이유3",skill:"춤",imageName:"iu3.jpg",url:"http://www.kakao.com"))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTableView(_:)))
        //RefreshControl을 생성
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        //iOS 10.0이상에서 수행
        if #available(iOS 10.0, *){
            tableView.refreshControl = refreshControl
        }else{
            tableView.addSubview(refreshControl)
        }
        
    }
    
    @objc func addTableView(_ sender:Any){
       data.append((name:"아이유4",skill:"운동",imageName:"iu1.jpg",url:"http://www.kakao.com"))
        //self.tableView.reloadData()
        //삽입하는 애니메이션을 추가
        let idx = IndexPath(row: self.data.count-1, section: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [idx], with: .right)
        self.tableView.endUpdates()
    }
        
    @objc func handleRefresh(_ sender:Any)
    {
        data.insert((name:"아이유5",skill:"영어",imageName:"iu2.jpeg",url:"http://www.naver.com"),at:0)
        data.insert((name:"아이유6",skill:"중국어",imageName:"iu3.jpg",url:"http://www.kakao.com"),at:0)
        //앞에 추가되어야 해서 행번호를 0번과 1번을 추가
        let idx1 = IndexPath(row: 0, section: 0)
        let idx2 = IndexPath(row: 1, section: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [idx1,idx2], with: .right)
        self.tableView.endUpdates()
        
        self.tableView.refreshControl?.endRefreshing()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.label1.text = data[indexPath.row].name
        cell.label2.text = data[indexPath.row].skill
        cell.img.image = UIImage(named:data[indexPath.row].imageName)
        //셀의 액세서리 설정
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    //셀의 높이를 설정하는 메소드
    override func tableView(_ tableView:UITableView,heightForRowAt indexPath: IndexPath)->CGFloat{
        return 100
    }
   
    
    //셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath){
        //사파리 앱 실행하기
        /*
        let url = URL(string: data[indexPath.row].url)
        UIApplication.shared.open(url!, options: [:])
        */
        
        //사파리 뷰 컨트롤러 실행
        /*
        let url = URL(string: data[indexPath.row].url)
        let safari = SFSafariViewController(url:url!)
        self.navigationController?.pushViewController(safari, animated: true)
        */
        
        //하위 뷰 컨트롤러 생성
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //데이터 넘겨주기
        detailViewController.url = data[indexPath.row].url
        //푸시
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        
        
    }
    
    
    //마지막 셀을 출력할 때 데이터를 업데이트 하기 위해서 셀을 출력할 때 호출되는 메소드를 재정의
    var flag = false
    
    override func tableView(_ tableView:UITableView, willDisplay cell:UITableViewCell, forRowAt indexPath: IndexPath){
        //맨 처음 마지막 셀을 출력할 때는 아무일도 하지 않음
        if flag == false && indexPath.row == self.data.count-1{
            flag = true
        }else if flag == true && indexPath.row == self.data.count-1{
            data.append((name:"아이유7",skill:"중국어",imageName:"iu3.jpg",url:"http://www.kakao.com"))
            data.append((name:"아이유8",skill:"중국어",imageName:"iu3.jpg",url:"http://www.kakao.com"))
            tableView.reloadData()
        }
    }
    
    
}
