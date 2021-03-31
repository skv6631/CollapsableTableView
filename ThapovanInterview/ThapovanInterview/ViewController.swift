//
//  ViewController.swift
//  Thapovan
//
//  Created by E5000416 on 30/03/21.
//

import UIKit

class ViewController: UIViewController {
    var comments = [CommentObject]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CollapsableCell.nib(), forCellReuseIdentifier: CollapsableCell.identifier)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        parseJSON()
    }
    func getJSONString() -> String {
        let json = """
        {
            "comments": [{
                    "comment": "Great.",
                    "replies": [
                        "Yes. Its really great",
                        "really useful.",
                        "thanks alot"
                    ]
                },
                {
                    "comment": "Awesome video.",
                    "replies": [
                        "thanks alot",
                        "Yes. Its really great.",
                        "really useful"
                    ]
                },
                {
                    "comment": "Nice tutorial.",
                    "replies": [
                        "Nice ! Thanks for this great videos !",
                        "really useful.",
                        "thanks alot"
                    ]
                },
                {
                    "comment": "Thanks for saving my day.",
                    "replies": [
                        "made my day",
                        "really useful.",
                        "thanks alot"
                    ]
                },
                {
                    "comment": "really useful.",
                    "replies": [
                        "Helpful",
                        "Nice tutorial for beginners.",
                        "thanks alot"
                    ]
                }
            ]
        }

"""
        return json
    }
    func parseJSON() {
        let str = getJSONString()
        let data = Data(str.utf8)
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] {
                print(jsonResult)
                comments.removeAll()
                for object in jsonResult["comments"] as? [NSDictionary] ?? []{
                    let comment = CommentObject(dict: object)
                    comments.append(comment)
                }
                tableView.reloadData()
            }
        } catch {
            print(error)
        }
        
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let comment = comments[section]
        if comment.isOpen {
            return (comment.replies.count) + 1
        }
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let comment = comments[indexPath.section]
            comment.isOpen.toggle()
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CollapsableCell.identifier) as? CollapsableCell {
            cell.configure(with: comments, indexPath: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

