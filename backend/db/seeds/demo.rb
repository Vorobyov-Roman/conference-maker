# users
creator1   = FactoryGirl.create :user, name: "The Illuminatis"

organizer1 = FactoryGirl.create :user, name: "Democratic Party"
organizer2 = FactoryGirl.create :user, name: "Republican Party"

trump      = FactoryGirl.create :user, name: "Donald Trump"
clinton    = FactoryGirl.create :user, name: "Hillary Clinton"



# conferences
conference1 = FactoryGirl.create :conference, title: "Trump rally",
                                              creator: creator1,
                                              organizers: [organizer2]

conference2 = FactoryGirl.create :conference, title: "Hillary rally",
                                              creator: creator1,
                                              organizers: [organizer1]



# topics
topic1 = FactoryGirl.create :topic, title: "Make America great again",
                                    conference: conference1,
                                    moderators: [trump]

topic1 = FactoryGirl.create :topic, title: "I'm With Her",
                                    conference: conference2,
                                    moderators: [clinton]
