//
//  ViewController.swift
//  HigherOrLower
//
//  Created by Jason Flooks on 30/01/2015.
//  Copyright (c) 2015 Rmando. All rights reserved.
//

import UIKit
import AOModalStatus

class ViewController: UIViewController {

    @IBOutlet weak var initialCardImageView: UIImageView!
    @IBOutlet weak var card1ImageView: UIImageView!
    @IBOutlet weak var card2ImageView: UIImageView!
    @IBOutlet weak var card3ImageView: UIImageView!
    @IBOutlet weak var card4ImageView: UIImageView!
    @IBOutlet weak var card5ImageView: UIImageView!
    @IBOutlet weak var buttonHigher: UIButton!
    @IBOutlet weak var buttonLower: UIButton!
    
    @IBOutlet weak var buttonNewGame: UIButton!
    @IBOutlet weak var initialCardTextButton: UIButton!

    @IBOutlet weak var buttonHigherConstraintXpos: NSLayoutConstraint!
    @IBOutlet weak var buttonHigherConstraintYpos: NSLayoutConstraint!
    
    @IBOutlet weak var buttonLowerConstraintXpos: NSLayoutConstraint!
    @IBOutlet weak var buttonLowerConstraintYpos: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"playingBackground.png"]]
        //window.backgroundColor = [UIColor, colorWithPatternImage,,:[UIImage imageNamed:@"Background.png"]];
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "playingBackground.png"))
        let yourImage = UIImage(named: "playingBackground.png")
        let imageview = UIImageView(image: yourImage)
        self.view.addSubview(imageview)
        
        newGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func initialCardSwap(_ sender: UIButton) {
        
        // User wants to change initial card
        if !initialCardSwapped {
            self.initialCardImageView.image = UIImage(named: shuffledDeck[6].simpleDescription())
            // The following line gives a Swift4 runtime error
            //Thread 1: Simultaneous accesses to 0x100e6e020, but modification requires exclusive access
            //swap(&shuffledDeck[0], &shuffledDeck[6])
            
            // So go old school?
            let newCard = shuffledDeck[6]
            shuffledDeck[0] = newCard
            _ = true
            initialCardTextButton.isHidden = true
        }
    }
    
    
    func presentModalStatusView(_ headline: String, _ imageName: String) {
        let modalView = AOModalStatusView(frame: self.view.bounds)
        let downloadImage = UIImage(named: imageName) ?? UIImage()
        modalView.set(image: downloadImage)
        modalView.set(headline: headline)
        view.addSubview(modalView)
    }
    
    
    
    @IBAction func newGame(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func higherButtonTapped(_ sender: UIButton) {
        playCard(currentPlayingCard, highORlow: "HIGHER")
    }
    
    @IBAction func lowerButtonTapped(_ sender: UIButton) {
        playCard(currentPlayingCard, highORlow: "LOWER")
    }
    
    func playCard (_ currentCard: NSInteger, highORlow: NSString ) {

        // First card played so remove ability to swap first card regardless
        initialCardTextButton.isHidden = true
        initialCardTextButton.isEnabled = false
        
        let previousCardValue = shuffledDeck[currentCard-1].rank.rawValue
        let playingCardValue = shuffledDeck[currentCard].rank.rawValue
        
        if (highORlow == "LOWER" && previousCardValue > playingCardValue) || (highORlow == "HIGHER" && previousCardValue < playingCardValue)
        {
            // correct guess - move on or finish game if last card
            
            if currentPlayingCard == 1 {
              self.card1ImageView.image = UIImage(named: shuffledDeck[currentPlayingCard].simpleDescription())
                
            }
            else if currentPlayingCard == 2 {
                self.card2ImageView.image = UIImage(named: shuffledDeck[currentPlayingCard].simpleDescription())
                
            }
            else if currentPlayingCard == 3 {
                self.card3ImageView.image = UIImage(named: shuffledDeck[currentPlayingCard].simpleDescription())
                
            }
            else if currentPlayingCard == 4 {
                self.card4ImageView.image = UIImage(named: shuffledDeck[currentPlayingCard].simpleDescription())
                
            }
            else if currentPlayingCard == 5 {
                self.card5ImageView.image = UIImage(named: shuffledDeck[currentPlayingCard].simpleDescription())
                // Last card - therefore we have a winner
                // Do some stuff...
                presentModalStatusView("W I N N E R !", "winner")
                resetButtons()
                
            }
            currentPlayingCard += 1
            // Need to move higher / lower "buttons"
            buttonHigherConstraintXpos.constant = CGFloat(115 + currentPlayingCard*140)
            buttonLowerConstraintXpos.constant = CGFloat(115 + currentPlayingCard*140)
        }
        else
        {
            // loser!!! end game  - show the full deck
            self.card1ImageView.image = UIImage(named: shuffledDeck[1].simpleDescription())
            self.card2ImageView.image = UIImage(named: shuffledDeck[2].simpleDescription())
            self.card3ImageView.image = UIImage(named: shuffledDeck[3].simpleDescription())
            self.card4ImageView.image = UIImage(named: shuffledDeck[4].simpleDescription())
            self.card5ImageView.image = UIImage(named: shuffledDeck[5].simpleDescription())
            resetButtons()
            presentModalStatusView("L O S E R !", "loser")
        }
        
    }
    
    func resetButtons () {
        
        buttonNewGame.isHidden = false
        buttonNewGame.isEnabled = true
        buttonHigher.isHidden = true
        buttonHigher.isEnabled = false
        buttonLower.isHidden = true
        buttonLower.isEnabled = false
    }
    
    func enableButtons () {
        
        buttonHigher.isHidden = false
        buttonHigher.isEnabled = true
        buttonLower.isHidden = false
        buttonLower.isEnabled = true
    }
    
    func newGame () {
        
        // Reset higher / lower "buttons"
        buttonHigherConstraintXpos.constant = 255
        buttonLowerConstraintXpos.constant = 255
        enableButtons()
        
        //winnerLoserLabel.isEnabled = false
        
        // Set the initial card
        self.card1ImageView.image = UIImage(named: "cardBackImage")
        self.card2ImageView.image = UIImage(named: "cardBackImage")
        self.card3ImageView.image = UIImage(named: "cardBackImage")
        self.card4ImageView.image = UIImage(named: "cardBackImage")
        self.card5ImageView.image = UIImage(named: "cardBackImage")
        initialCardSwapped = false
        initialCardTextButton.isHidden = false
        initialCardTextButton.isEnabled = false
        buttonNewGame.isHidden = true
        buttonNewGame.isEnabled = false
        currentPlayingCard = 1
        shuffledDeck = fullDeck.shuffled()

        self.initialCardImageView.image = UIImage(named: shuffledDeck[0].simpleDescription())
        
    }
    
}

