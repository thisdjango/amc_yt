//
//  TableViewController.swift
//  amc-youtube
//
//  Created by thisdjango on 28.01.2020.
//  Copyright © 2020 thisdjango. All rights reserved.
//

import UIKit
//import ListPlaceholder

var playlistsData:[Item] = []

class TableViewController: UITableViewController{
    var labels:[String] = []
    let lock = NSLock()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(labels.count)
        
        Service.grabData {
            return PLAYLIST_URL_LINK
        }
        
        Service.grabTitleAndVideo { playlist in
            self.labels.append(playlist.snippet.title)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        Service.grabMediaContent { img_mov, str_mov in
            previewImages.append(PreviewImagesVideoSet(previewImagesVideos: img_mov))
            titlesVideo.append(TitleVideoSet(titlesVideoset: str_mov))
        }
        
        print(playlistsData.count)

    }

    override func viewWillAppear(_ animated: Bool) {
        print("WILL APPREAR")
        print(labels.count)
        print(playlistsData.count)
        print(previewImages.count)
        print("that's all )")
    }
    
    override func viewDidLayoutSubviews() {
        print("DID SUBVIEWS")
        print(labels.count)
        print(playlistsData.count)
        print(previewImages.count)
        print("that's all )")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print("MAIN  -------> \(labels.count)")
        return labels.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idcell", for: indexPath) as! TableViewCell
        cell.mytitle.text = labels[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
