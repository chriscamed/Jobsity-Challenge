//
//  SerieDetailViewController.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/20/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit
import PagingMenuController

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    private let detailTab = SerieDetailTabViewController.instantiateFromStoryboard()
    private let episodesTab = SerieEpisodesTabViewController.instantiateFromStoryboard()
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        return [detailTab, episodesTab]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2()]
        }
        var backgroundColor: UIColor {
            return UIColor.clear
        }
        var selectedBackgroundColor: UIColor {
            return UIColor.clear
        }
        var focusMode: MenuFocusMode {
            return .underline(height: 4.0, color:  UIColor(rgba: "#167ED6"), horizontalPadding: 0.0, verticalPadding: 0.0)
        }
    }
    
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let text = "Detail"
            let color = UIColor.white
            let selectedColor = UIColor.white
            let font = UIFont.systemFont(ofSize: 24)
            let selectedFont = UIFont.boldSystemFont(ofSize: 24)
            return .text(title: MenuItemText(text: text,
                                             color: color,
                                             selectedColor: selectedColor,
                                             font: font,
                                             selectedFont: selectedFont))
        }
    }
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let text = "Episodes"
            let color = UIColor.white
            let selectedColor = UIColor.white
            let font = UIFont.systemFont(ofSize: 24)
            let selectedFont = UIFont.boldSystemFont(ofSize: 24)
            return .text(title: MenuItemText(text: text,
                                             color: color,
                                             selectedColor: selectedColor,
                                             font: font,
                                             selectedFont: selectedFont))
        }
    }
}

class SerieDetailViewController: UIViewController {
    
    var serie: Serie?    
    @IBOutlet weak var seriePosterImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        let options = PagingMenuOptions()
        
        let pagingMenuController = PagingMenuController(options: options)
        
        pagingMenuController.view.frame.origin.y += 250
        pagingMenuController.view.frame.size.height -= 250
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .didMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case .didScrollStart:
                print("Scroll start")
            case .didScrollEnd:
                print("Scroll end")
            }
        }
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        
        let detailTab = pagingMenuController.pagingViewController?.controllers[0] as! SerieDetailTabViewController
        detailTab.serieNameLabel.text = serie!.name
        detailTab.scheduleLabel.text = "\(serie!.time) - \(serie!.days.joined(separator: ", "))"
        detailTab.genresLabel.text = "\(serie!.genres.joined(separator: ", "))"
        var attrString = NSMutableAttributedString()
        do {
            attrString = try NSMutableAttributedString(data: serie!.summary.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                                                       options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                 NSForegroundColorAttributeName: UIColor.black],
                                                       documentAttributes: nil)
            
            let fullRange : NSRange = NSMakeRange(0, attrString.length)
            attrString.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 17)], range: fullRange)
            detailTab.summaryTextView.attributedText = attrString
            detailTab.summaryTextView.contentOffset = CGPoint.zero
            let placeholderImg = UIImage(named: "placeholder_img.jpg")
            if let imgURL = serie!.posterImgURL {
                seriePosterImageView.af_setImage(withURL: URL(string: imgURL)!, placeholderImage: placeholderImg)
            }
        } catch {
            print(error)
        }
        
        
        let episodesTab = pagingMenuController.pagingViewController?.controllers[1] as! SerieEpisodesTabViewController
        episodesTab.serie = serie
        episodesTab.loadData()
        
        pagingMenuController.didMove(toParentViewController: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
