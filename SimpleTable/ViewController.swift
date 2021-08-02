//
//  ViewController.swift
//  SimpleTable
//
//  Created by kwon on 2021/08/01.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    let customCellIdentifier: String = "customCell"
    let korean: [String] = ["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "파", "타", "하"]
    let english: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var dates: [Date] = []
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
    
    @IBAction func touchUpAddButton(_ sender: UIButton) {
        dates.append(Date())
        // self.tableView.reloadData() 일부가 아닌 전체 데이터를 다시 불러옴
        self.tableView.reloadSections(IndexSet(2...2), with: UITableView.RowAnimation.automatic)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 스토리보드에서 연결하지 않고 코드로 연결하는 방법
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
    }

    // 옵셔널이 아니어서 UITableViewDataSource를 채택하면 무조건 구현해야 하는 메서드
    // 테이블뷰가 우리에게 물어보는 것. 몇 개의 row를 준비해야 하는가?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return korean.count
        case 1:
            return english.count
        case 2:
            return dates.count
        default:
            return 0
        }
    }

    // 옵셔널이 아니어서 UITableViewDataSource를 채택하면 무조건 구현해야 하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < 2 {
            // dequeueReusableCell: 재사용 큐에 쌓여있던 셀을 꺼내와서 사용한다는 의미
            // let cell: UITableViewCell = UITableViewCell() 하지 않는 이유
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
            let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
            cell.textLabel?.text = text
            
            // cell의 재사용 여부 확인용
            if indexPath.row == 1 {
                cell.backgroundColor = UIColor.yellow
            } else {
                // else를 추가해서 재사용된 셀이 다음에 다시 등장할 때 계속 노란색이 되는 걸 방지
                cell.backgroundColor = UIColor.white
            }
            
            return cell
        } else {
            guard let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.customCellIdentifier, for: indexPath) as? CustomTableViewCell else {
                preconditionFailure("테이블 뷰 셀 가져오기 실패")
            }
            
            cell.leftLabel.text = self.dateFormatter.string(from: self.dates[indexPath.row])
            cell.rightLabel.text = self.timeFormatter.string(from: self.dates[indexPath.row])
            
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < 2 {
            return section == 0 ? "한글" : "영어"
        }
        
        return nil
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let nextViewController: SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        nextViewController.textToSet = cell.textLabel?.text
        // 직접 outlet에 셋팅해주는 게 안되는 이유
        // prepare과정에서 세그의 목적지가 되는 뷰 컨트롤러의 객체는 생성이 되어있지만
        // 그 안의 뷰 요소들은 아직 메모리에 올라와있지 않은 상태라서
        // label에 직접 넣어주려고 하면 런타임 에러가 발생한다
        // 대신 ui에 보여지지 않는 요소라면 바로 전달해도 무방
        // nextViewController.label.text = cell.textLabel?.text
    }
}

