//
//  MemoList.swift
//  slider
//
//  Created by 알버트 on 2017. 8. 22..
//  Copyright © 2017년 visionboy.me. All rights reserved.
//

import UIKit


struct MemoInfo {
    var no: Int32
    var ctt: String
    var reg_date: String
}

class MemoList: UITableViewController {
    
    @IBOutlet var menuButton: UIBarButtonItem!
    
    var Memos : [MemoInfo]=[]
    
    var gNo : String = ""

    @IBOutlet var tbView: UITableView!
    
    let cellSpacingHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        self.refreshControl = UIRefreshControl()
        //
        self.refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        // Configure Refresh Control
        
        //tbView.addSubview(refreshControl!)
        
        Memos = GetMemoList()
        
        self.refreshControl?.endRefreshing()
        
        if (self.gNo != "") {
            reBindTableData() 
        }
        
        //deleteMemo()

    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Memos.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellId:String = "memoList"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? MemoTableCell; //？是可选的 就是可能是nil

        let currentCell = Memos[indexPath.row]
        
        cell?.reg_date.text = currentCell.reg_date
        
        cell?.ctt.text = currentCell.ctt
        
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView!
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = BaseController.BS.hexStringToUIColor("#4089e8")
        return headerView
    }
    

    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            NSLog("DELETE")
            
            let sql = "delete from memo where no = ?"
            let currentCell = self.Memos[indexPath.row]
            let result = SQLiteManager.shareInstance.db!.executeUpdate(sql, withArgumentsInArray: [String(currentCell.no)])
            
            self.Memos = self.GetMemoList()
            self.tbView.reloadData()
            
        }
        
        let edite = UITableViewRowAction(style: .Normal , title: "Edit") { (action, indexPath) in
            // share item at indexPath
            let currentCell = self.Memos[indexPath.row]
            self.EditeMemo(String(currentCell.no))
        }
        
        return [delete, edite]

    }
    
    func EditeMemo(no:String) {
        if let rvc = self.storyboard?.instantiateViewControllerWithIdentifier("RegistMemo") as? RegistMemo {
            rvc.no = no
            self.navigationController?.pushViewController(rvc, animated: true)
        }
    }
    

    
//    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
////        if (self.tableView.editing) {
////            return UITableViewCellEditingStyle.Delete
////        }
//        return UITableViewCellEditingStyle.Insert
//    }
    
//     func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
//        
//        var deleteAction = UITableViewRowAction(style: .Default, title: "Delete") {action in
//            //handle delete
//        }
//        
//        var editAction = UITableViewRowAction(style: .Normal, title: "Edit") {action in
//            //handle edit
//        }
//        
//        return [deleteAction, editAction]
//    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let sql = "delete from memo where no = ?"
//        let currentCell = Memos[indexPath.row]
//        let result = SQLiteManager.shareInstance.db!.executeUpdate(sql, withArgumentsInArray: [String(currentCell.no)])
//        print("You tapped cell number \(indexPath.row).")
//        tbView.beginUpdates()
//        tbView.reloadData()
//        tbView.endUpdates()
    }
    

    
    @IBAction func reloadc(sender: AnyObject) {
        reBindTableData()
    }

    
    
    func refresh(sender:AnyObject) {
        // Code to refresh table view
        NSLog("refresh")
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        //let NewMemo = MemoInfo(no: 1000,ctt: "it is contents",reg_date: "reg date hahaha")
        //
        
//        tbView.beginUpdates()
//        Memos.append(NewMemo)
//        tbView.insertRowsAtIndexPaths([
//            NSIndexPath(forRow: Memos.count-1, inSection: 0)
//            ], withRowAnimation: .Automatic)
//        tbView.endUpdates()
        reBindTableData()
        self.refreshControl?.endRefreshing()
    }
    
    func reBindTableData() {
        Memos = GetMemoList()
        tbView.reloadData()
    }
    
    func deleteMemo()  {
        let sql = "delete from memo"
        let result = SQLiteManager.shareInstance.db!.executeQuery(sql, withArgumentsInArray: [0])
    }
    
    func GetMemoList()->[MemoInfo] {
        var Gmemos : [MemoInfo] = []
        let sql2 = "SELECT no, ctt, reg_date FROM memo order by no desc;"
        let result = SQLiteManager.shareInstance.db!.executeQuery(sql2, withArgumentsInArray: [0])
        
        while result!.next()
        {
            let no = result?.intForColumn("no")
            let ctt = result?.stringForColumn("ctt")
            let regdate = result?.stringForColumn("reg_date")
            let memo = MemoInfo(no: no!,ctt: ctt!,reg_date: regdate!)
            
            Gmemos.append(memo)
        }
        
        return Gmemos
    }
    
    //dispatch_async(dispatch_get_main_queue(), { self.tableView.reloadData() })
    
    @IBAction func MemoRegist(sender: AnyObject) {
        if let uvc = self.storyboard?.instantiateViewControllerWithIdentifier("RegistMemo") {
            self.navigationController?.pushViewController(uvc, animated: true)
        }
    }
    
}
    