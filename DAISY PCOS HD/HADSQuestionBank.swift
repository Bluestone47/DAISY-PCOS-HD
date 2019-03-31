//
//  HADSQuestionBank.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import Foundation

class HADSQuestionBank {
    
    var list = [HADSQuestion]()
    
    init() {
        
        list.append(HADSQuestion(text: "I feel tense or 'wound up':",
                                 answer: ["Most of the time", "A lot of the time", "From time to time, occasionally", "Not at all"],
                                 whatFor: "A"))
        list.append(HADSQuestion(text: "I feel as if I am slowed down:",
                                 answer: ["Nearly all the time", "Very often", "Sometimes", "Not at all"],
                                 whatFor: "D"))
        list.append(HADSQuestion(text: "I still enjoy the things I used to enjoy:",
                                 answer: ["Hardly at all", "Only a little", "Not quite so much", "Definitely as much"],
                                 whatFor: "D"))
        list.append(HADSQuestion(text: "I get a sort of frightened feeling like 'butterflies' in the stomach:",
                                 answer: ["Very Often", "Quite Often", "Occasionally", "Not at all"],
                                 whatFor: "A"))
        list.append(HADSQuestion(text: "I get a sort of frightened feeling as if something awful is about to happen:",
                                 answer: ["Very definitely and quite badly", "Yes, but not too badly", "A little, but it doesn't worry me", "Not at all"],
                                 whatFor: "A"))
        list.append(HADSQuestion(text: "I have lost interest in my appearance:",
                                 answer: ["Definitely", "I don't take as much care as I should", "I may not take quite as much care", "I take just as much care as ever"],
                                 whatFor: "D"))
        list.append(HADSQuestion(text: "I can laugh and see the funny side of things:",
                                 answer: ["Not at all", "Definitely not so much now", "Not quite so much now", "As much as I always could"],
                                 whatFor: "D"))
        list.append(HADSQuestion(text: "I feel restless as I have to be on the move:",
                                 answer: ["Very much indeed", "Quite a lot", "Not very much", "Not at all"],
                                 whatFor: "A"))
        list.append(HADSQuestion(text: "Worrying thoughts go through my mind:",
                                 answer: ["A great deal of the time", "A lot of the time", "From time to time, but not too often", "Only occasionally"],
                                 whatFor: "A"))
        list.append(HADSQuestion(text: "I look forward with enjoyment to things:",
                                 answer: ["Hardly at all", "Definitely less than I used to", "Rather less than I used to", "As much as I ever did"],
                                 whatFor: "D"))
        list.append(HADSQuestion(text: "I feel cheerful:",
                                 answer: ["Not at all", "Not often", "Sometimes", "Most of the time"],
                                 whatFor: "D"))
        list.append(HADSQuestion(text: "I get sudden feelings of panic:",
                                 answer: ["Very often indeed", "Quite often", "Not very often", "Not at all"],
                                 whatFor: "A"))
        list.append(HADSQuestion(text: "I can sit at ease and feel relaxed:",
                                 answer: ["Not at all", "Not Often", "Usually", "Definitely"],
                                 whatFor: "A"))
        list.append(HADSQuestion(text: "I can enjoy a good book or radio or TV program:",
                                 answer: ["Very seldom", "Not often", "Sometimes", "Often"],
                                 whatFor: "D"))
        
        
    }
    
}
