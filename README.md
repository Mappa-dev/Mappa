#LEAGUE OF LEGENDS: A DEATH LOCATOR APPLICATION

###Application Name Ideas
* Kappography
* Mappa
* Ekko Locator (like batman… and could perhaps expand to more than death locators… future expansion pack… DLC Kappa)

###Goal
>To produce an application wherein users can enter in their user information, then the locations in which the users’ death locations from previous games is then entered into a map. Users are also able to sign up and create accounts, include their favourite users as well as connect with other users.

####Steps Needed to Reach the End Goal
- [x] decipher deocumentation of api wrapper gem
- [ ] access data retrieved from api wrapper and print on the webpage
- [ ] create a ER model for the database
- [ ] store the data from api wrapper into the database
- [ ] access data from database and print to the webpage
- [ ] create a layout for how the site will look
- [ ] implement layout using Bootstrap (Bill Turner...)
- [ ] finishing touches

###Application Base
>This application will be developed through Ruby on Rails with Heroku support. Additional plugins will be included below.

###Plugins
* three.js
* Bootstrap 4
* Riot Games API

###API Keys:
> An Application specific environment variable needs to be set.
  1. create a `.env` in the root directory
  2. add the line: `RIOT_API_KEY = XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXX` to the `.env` file.
  3. add `.env` to the file `.gitignore` to maintain security of the key and not push the key to the repository.
  4. access the key as follows in the Ruby files: `this_key = ENV["RIOT_API_KEY"]`
      
###Useful functionalities:
`GET /api/lol/{region}/v1.4/summoner/by-name/{summonerNames}`
Gets summoner by summoner name - is converted to lowercase and then has whitespace removed. Multiple summoner names can be given, but they must be comma-spaced. Mostly, at this point we’re interested in getting the ID.


`GET /api/lol/{region}/v2.2/matchlist/by-summoner/{summonerId}`
Gets the MatchList by the ID. This list can be expanded infinitely in length. The MatchList contains a list of MatchReferences, which are each of the individual matches attached to the ID. The list can be further queried by time, or by index (if the numbers are known).

`GET /api/lol/{region}/v2.2/match/{matchId}`
Gets the match (in varied detail) with respect to the match ID provided. Right now, we’re only interested in the value for the deaths attributed to the participantId and the location (x, y coordinates). These deaths will be logged later on.

For each event, check if the eventType = CHAMPION_KILL, and check if victimId = participantId. The eventType is actually irrelevant because the victimId will only be present if the eventType is a champion killed. If so, log the X and Y coordinates of the event.

In each match, the participants are stored under:
```json
"participantIdentities": [
            "player": {
                        "profileIcon": 684,
                        "matchHistoryUri": "/v1/stats/player_history/NA/36395109",
                        "summonerName": "Naughty Hobby",
                        "summonerId": 22556059
            },
            "participantId": 1
]
```
So, the process for this stage will likely form as such:
Identify the relevant user via searching through participantIdentities to find the participantId which matches the summonerId presented.
Identify the death events for the player, and log the x, y of the deaths in an array.

###Map Representations
http://kotaku.com/league-of-legends-main-map-in-all-its-glory-1719074381?hipra_discussion_redesign=off&utm_expid=66866090-52.r5txldOmRkqnbJxnyozIeA.1&utm_referrer=https%3A%2F%2Fwww.google.ca%2F

###Additional Resources
* https://www.codecademy.com/courses/ruby-beginner-en-pEdhY/0/1?curriculum_id=5122d839c0a131c35f00013d
    * Using API in Ruby.

* https://rubygems.org/gems/riot_lol_api
    * http://www.rubydoc.info/gems/riot_lol_api/0.3.2
    * https://github.com/francois-blanchard/riot_lol_api
    * Riot API wrapper in Ruby. Preferred version to use?
* https://www.reddit.com/r/InternetIsBeautiful/comments/36midi/italian_jewellers_desktop_website_is_a_blend_of/
    * How to render multi-page images in web browser. Probably have to use a pixi.js implementation?
* http://spin.atomicobject.com/2013/11/05/opal-ruby-browser/
    * Ruby wrapper for pixi.js - possible large map implementation.
* http://www.tutorialspoint.com/ruby-on-rails/rails-directory-structure.htm
    * Rails directory structure tutorial - helpful for adding assets/ use of coffeescript/ etc,.

