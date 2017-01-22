//
//  ViewController.swift
//  NumbersPuzzle
//
//  Created by apple on 17/01/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bound = 0
    
    var gridSize: CGFloat = 3
    
    var container = [UIButton]()
    var puzzleArray: [Int] = []
    var tagCount = 0
    let framLayerWidth: CGFloat = 1
    var pWidth: CGFloat = 100
    var pHeight: CGFloat = 100
    
    private let gameEninge = Engine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //generate the puzzle
        
        gameEninge.generatePuzzle(piece: &puzzleArray, upTo: bound)
        
        //set the grid origins
        var originX = self.view.frame.width/2 - ((pWidth * gridSize) / 2)
        var originY = self.view.frame.height/2 - ((pHeight * gridSize) / 2)
        
        //construct the grid
        for _ in 0 ..< Int(gridSize) {
            for _ in 0 ..< Int(gridSize) {
                constructObjectRect(x: originX, y: originY, width: pWidth, height: pHeight, storeIn: &container, withTag: &tagCount)
                
                originX += pWidth
            }
            
            originX -= (pWidth * gridSize)
            originY += pHeight
        }
        
        //add grid components to the view
        for item in container {
            self.view.addSubview(item)
        }
        
        //populate the grid objects
        for i in 0 ..< bound {
            container[i].setTitle(String(puzzleArray[i]), for: UIControlState())
        }
        
        container.last?.setTitle("", for: UIControlState())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    private func performMove(from piece1: UIButton, to piece2: UIButton) {
        piece2.setTitle(piece1.currentTitle, for: UIControlState())
        piece1.setTitle("", for: UIControlState())
    }
    
    @IBAction func onPuzzlePiece(_ sender: UIButton) {
        
        let slotTag = sender.tag
        var changed = false
        
        if slotTag + 1 % Int(gridSize) == 0 {
            
            if slotTag + Int(gridSize) < bound + 1 {
                if container[slotTag + Int(gridSize)].currentTitle == ""   {
                    performMove(from: sender, to: container[slotTag + Int(gridSize)])
                    changed = true
                }
            }
            
            if slotTag - 1 >= 0 && !changed {
                if container[slotTag - 1].currentTitle == ""  {
                    performMove(from: sender, to: container[slotTag - 1])
                    changed = true
                }
            
            }
            
            if slotTag - Int(gridSize) >= 0 && !changed {
                if container[slotTag - Int(gridSize)].currentTitle == ""  {
                    performMove(from: sender, to: container[slotTag - Int(gridSize)])
                    changed = true
                }
            }
        }
        
        else if slotTag % Int(gridSize) == 0 {
            
            if slotTag + Int(gridSize) < bound + 1 {
                if container[slotTag + Int(gridSize)].currentTitle == ""  {
                    performMove(from: sender, to: container[slotTag + Int(gridSize)])
                    changed = true
                }
            }
                
            if slotTag + 1 < bound + 1 && !changed {
                if container[slotTag + 1].currentTitle == ""  {
                    performMove(from: sender, to: container[slotTag + 1])
                    changed = true
                }
            }
  
            if slotTag - Int(gridSize) >= 0 && !changed {
                if container[slotTag - Int(gridSize)].currentTitle == ""  {
                    performMove(from: sender, to: container[slotTag - Int(gridSize)])
                    changed = true
                }
            }
        }
        
        else {
            
            if slotTag + Int(gridSize) < bound + 1 {
                if container[slotTag + Int(gridSize)].currentTitle == ""   {
                    performMove(from: sender, to: container[slotTag + Int(gridSize)])
                    changed = true
                }
            }
                
            if slotTag - 1 >= 0 && !changed {
                if container[slotTag - 1].currentTitle == ""  {
                    performMove(from: sender, to: container[slotTag - 1])
                    changed = true
                }
            }
            
            if slotTag - Int(gridSize) >= 0 && !changed {
                if container[slotTag - Int(gridSize)].currentTitle == ""  {
                    performMove(from: sender, to: container[slotTag - Int(gridSize)])
                    changed = true
                }
            }
            
            if slotTag + 1 < bound + 1 && !changed {
                if container[slotTag + 1].currentTitle == ""  {
                    performMove(from: sender, to: container[slotTag + 1])
                    changed = true
                }
            }
        }
    }
    
    private func constructObjectRect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, storeIn arrayOfObjs: inout [UIButton], withTag tag: inout Int) {
        
        let obj = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
        setProperties(for: obj, andTag: tag)
        arrayOfObjs.append(obj)
        tag += 1
        
    }
    
    private func setProperties(for item: UIButton, andTag tagID: Int) {
        item.addTarget(self, action: #selector(onPuzzlePiece), for: .touchUpInside)
        item.setTitleColor(UIColor.init(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
        item.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        item.backgroundColor = UIColor.white
        item.tag = tagID
        item.layer.borderWidth = framLayerWidth
        item.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func onNewGame(_ sender: UIBarButtonItem) {
        let action = UIAlertController(title: nil, message: "Are you sure you want to start a new game?", preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: {
            action in
            
            self.performSegue(withIdentifier: "unwindToMenu", sender: UIBarButtonItem())
        })
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        action.addAction(yesAction)
        action.addAction(noAction)
        self.present(action, animated: true, completion: nil)
        
    }
    
    

}

