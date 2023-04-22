# Space--Workday

Hi! Thanks for checking out my "Space!" project!

I've left some notes below on my approach to building this project as well as how to run it. Looking forward to hearing what you think!

Thanks,

Dave


## Notes on Development and Architecture
- I built the search view and results table in UIKit, and the results cells and detail view in SwiftUI.
- I used async/await wherever possible. I love how it reads as if synchronous code and I feel it's more straightforward to test
- I used MVVM Architecture Pattern to keep UI and Functionality separate
- Note the 'twinkle' effect on the stars on the search screen. Thought it was a nice touch!
- Immediately after submitting this I realized I didn't handle a "No Results" scenario, and had a few incomplete unit tests. Given more time I would have updated the results page to display a message saying there weren't any results for that search term and would have added the unit tests I didn't quite complete.
- It seems like I'm getting a strange message in the console. It looks like this might be an iOS 16 specific error, but given more time I’d investigate the cause and get it to stop displaying, but no current issues with functionality.

## Steps to run the app
1. Navigate to https://github.com/dpiernick/Space--Workday
2. Click "Code"
3. Click "Open in Xcode"
4. Choose where to save the project
5. Click "Run"!
 - OR
1. Download "Space!.zip" from either the file submitted via HackerRank or through https://drive.google.com/file/d/1MQjjeHY8ARteGQ3f1KSXMzlDkIPHqQKA/view?usp=sharing
2. Unzip the file
3. Open the unzipped file in Xcode
4. Click "Run"!
