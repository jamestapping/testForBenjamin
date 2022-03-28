//
//  ViewController.swift
//  quotes
//
//  Created by james on 23/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var quotes: [QuotesQuery.Data.Quote] = []
    var quoteCount = 0
    var progressCount: Float = 0.0
    var completedPercentageCount = 0
    var finished = false
    
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var citation: UILabel!
    @IBOutlet weak var completedPercentage: UILabel!
    @IBOutlet weak var nextCitationButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.progress = 0.0
        
        getAllQuotes()
        
    }
    
    @IBAction func didTapNextCitation(_ sender: Any) {
        
        guard !finished else { return }
        
        if finished {
            
            quoteCount = 0
            progressCount = 0.0
            completedPercentageCount = 0
            
            DispatchQueue.main.async { [self] in
                
                author.text = quotes[quoteCount].author
                citation.text = quotes[quoteCount].quote
                completedPercentage.text = String(completedPercentageCount)+"%"
                
            }
            
        }

        completedPercentageCount += 10
        
        DispatchQueue.main.async { [self] in
            
            author.text = quotes[quoteCount].author
            citation.text = quotes[quoteCount].quote
            completedPercentage.text = String(completedPercentageCount)+"%"
            
        }
        
        quoteCount += 1
        progressCount += 0.1
        
        progressView.progress = progressCount
        
        if completedPercentageCount == 50 {
            
            // show modal
            
            self.openAlert(title: "Tu es à 50% des citations",
                                     message: "Tu as bientôt fini!",
                           alertStyle: .alert,
                                     actionTitles: ["Arrêter","Continuer"],
                                     actionStyles: [.default, .default],
                                     actions: [
                                      {_ in
                                          
                                          self.dismiss(animated: true, completion: nil)
                                      },
                                      {_ in
                                          
                                          // Show finished view
                                          
                                      }
                                     ])
                  }
        
        if completedPercentageCount == 100 {
            
            
            handleFinished()
            
        }
         
    }
            
    
    func getAllQuotes() {
        
        Network.shared.apollo.fetch(query: QuotesQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                
                if let gotQuotes = graphQLResult.data?.quotes.compactMap({ $0 }) {
                    
                    self.quotes = gotQuotes
                    
                }
                
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
    
    func handleFinished() {
        
        nextCitationButton.setTitle("                  FINIR                 ", for: .normal)
        
        finished = true
        
        openSimpleAlert(title: "C'est fini!", message: "Game Over!")
        
    }
    
}

