//
//  BotMatchViewController.swift
//  Quake3-iOS
//
//  Created by Tom Kidd on 12/4/19.
//  Copyright © 2019 Tom Kidd. All rights reserved.
//

import UIKit

protocol BotMatchProtocol {
    func setMap(map:String, name: String)
    func addBot(bot:String, difficulty: Float)
}

class BotMatchViewController: UIViewController {
    
    @IBOutlet weak var botList: UITableView!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var mapShot: UIImageView!
    
    @IBOutlet weak var skill1Button: UIButton!
    @IBOutlet weak var skill2Button: UIButton!
    @IBOutlet weak var skill3Button: UIButton!
    @IBOutlet weak var skill4Button: UIButton!
    @IBOutlet weak var skill5Button: UIButton!
    
    var fragLimit = 20
    
    @IBOutlet weak var fragLimitLabel: UILabel!
    @IBOutlet weak var incrementFragLimitButton: UIButton!
    @IBOutlet weak var decrementFragLimitButton: UIButton!
    
    var timeLimit = 0

    @IBOutlet weak var timeLimitLabel: UILabel!
    @IBOutlet weak var incrementTimeLimitButton: UIButton!
    @IBOutlet weak var decrementTimeLimitButton: UIButton!

    var botSkill = 3.0
    
    var selectedMap = "Q3DM1"

    let fileManager = FileManager()
    var documentsDir = ""

    var bots = [(name: String, skill: Float)]()

    override func viewDidLoad() {
        super.viewDidLoad()

        botList.mask = nil
        botList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        documentsDir = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).path
        
        var destinationURL = URL(fileURLWithPath: documentsDir)
        destinationURL.appendPathComponent("graphics/\(selectedMap).jpg")
        mapShot.image = UIImage(contentsOfFile: destinationURL.path)
        
        var skill1URL = URL(fileURLWithPath: documentsDir)
        skill1URL.appendPathComponent("graphics/menu/art/skill1.tga")
        skill1Button.setImage(UIImage.image(fromTGAFile: skill1URL.path) as? UIImage, for: .normal)
        skill1Button.layer.borderColor = UIColor.red.cgColor

        var skill2URL = URL(fileURLWithPath: documentsDir)
        skill2URL.appendPathComponent("graphics/menu/art/skill2.tga")
        skill2Button.setImage(UIImage.image(fromTGAFile: skill2URL.path) as? UIImage, for: .normal)
        skill2Button.layer.borderColor = UIColor.red.cgColor

        var skill3URL = URL(fileURLWithPath: documentsDir)
        skill3URL.appendPathComponent("graphics/menu/art/skill3.tga")
        skill3Button.setImage(UIImage.image(fromTGAFile: skill3URL.path) as? UIImage, for: .normal)
        skill3Button.layer.borderColor = UIColor.red.cgColor
        skill3Button.layer.borderWidth = 2

        var skill4URL = URL(fileURLWithPath: documentsDir)
        skill4URL.appendPathComponent("graphics/menu/art/skill4.tga")
        skill4Button.setImage(UIImage.image(fromTGAFile: skill4URL.path) as? UIImage, for: .normal)
        skill4Button.layer.borderColor = UIColor.red.cgColor

        var skill5URL = URL(fileURLWithPath: documentsDir)
        skill5URL.appendPathComponent("graphics/menu/art/skill5.tga")
        skill5Button.setImage(UIImage.image(fromTGAFile: skill5URL.path) as? UIImage, for: .normal)
        skill5Button.layer.borderColor = UIColor.red.cgColor
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BotMatchSegue" {
            (segue.destination as! GameViewController).selectedMap = selectedMap
            (segue.destination as! GameViewController).botMatch = true
            (segue.destination as! GameViewController).botSkill = botSkill
            (segue.destination as! GameViewController).bots = bots
            (segue.destination as! GameViewController).fragLimit = fragLimit
            (segue.destination as! GameViewController).timeLimit = timeLimit
        } else if segue.identifier == "BotMatchMapSegue" {
            (segue.destination as! BotMatchMapViewController).delegate = self
            (segue.destination as! BotMatchMapViewController).selectedMap = selectedMap
        } else if segue.identifier == "BotMatchBotSegue" {
            (segue.destination as! BotMatchBotViewController).delegate = self
        }
    }
    
    @IBAction func incrementFragLimit(_ sender: UIButton) {
        fragLimit += 1
        fragLimitLabel.text = String(fragLimit)
    }
    
    @IBAction func decrementFragLimit(_ sender: UIButton) {
        if fragLimit > 0 {
            fragLimit -= 1
            fragLimitLabel.text = String(fragLimit)
        }
    }

    @IBAction func incrementTimeLimit(_ sender: UIButton) {
        timeLimit += 1
        timeLimitLabel.text = String(timeLimit)
    }
    
    @IBAction func decrementTimeLimit(_ sender: UIButton) {
        if timeLimit > 0 {
            timeLimit -= 1
            timeLimitLabel.text = String(timeLimit)
        }
    }
    
    func clearSkills(_ sender: UIButton) {
        skill1Button.layer.borderWidth = 0
        skill2Button.layer.borderWidth = 0
        skill3Button.layer.borderWidth = 0
        skill4Button.layer.borderWidth = 0
        skill5Button.layer.borderWidth = 0
        sender.layer.borderWidth = 1
    }

    @IBAction func skill1(_ sender: UIButton) {
        self.botSkill = 1
        clearSkills(sender)
    }
    
    @IBAction func skill2(_ sender: UIButton) {
        self.botSkill = 2
        clearSkills(sender)
    }
    
    @IBAction func skill3(_ sender: UIButton) {
        self.botSkill = 3
        clearSkills(sender)
    }
    
    @IBAction func skill4(_ sender: UIButton) {
        self.botSkill = 4
        clearSkills(sender)
    }
    
    @IBAction func skill5(_ sender: UIButton) {
        self.botSkill = 5
        clearSkills(sender)
    }
}

extension BotMatchViewController: BotMatchProtocol {
    func setMap(map: String, name: String) {
        mapButton.setTitle(map, for: .normal)
        selectedMap = map
        var destinationURL = URL(fileURLWithPath: documentsDir)
        destinationURL.appendPathComponent("graphics/\(selectedMap).jpg")
        mapShot.image = UIImage(contentsOfFile: destinationURL.path)
    }
    
    func addBot(bot: String, difficulty: Float) {
        bots.append((name: bot, skill: difficulty))
        botList.reloadData()
    }
}

extension BotMatchViewController : UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.delegate?.setMap(map: bots[indexPath.row].map, name: maps[indexPath.row].name)
//        self.dismiss(animated: true, completion: nil)
//    }
    
}

extension BotMatchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(bots[indexPath.row].name) (skill: \(bots[indexPath.row].skill))"
        return cell
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

