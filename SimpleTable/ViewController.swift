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
    let korean: [String] = ["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "파", "타", "하"]
    let english: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

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
            return  english.count
        default:
            return 0
        }
    }

    // 옵셔널이 아니어서 UITableViewDataSource를 채택하면 무조건 구현해야 하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
        
        cell.textLabel?.text = text
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "한글" : "영어"
    }
}

