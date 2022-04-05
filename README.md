# AllRestaurants

Here's my coding submission for AllTrails!

### Notes: 
1) I picked SwiftUI over UIKit mostly for a challenge - I primarily use UIKit day-to-day, so it was good to mix it up a bit. In retrospect, I would probably code the `MapView` using UIKit instead. It was really tricky to get the callout to display correctly - you may have to tap the annotations several times to get them to appear correctly. I remember this being pretty easy to do in UIKit.
2) I tried my best to match the specs but fell a little short on time! Given more time I'd try to make it pixel perfect. 
3) I utilized MVVM-C for the architecture. The coordinator was a little tricky to set up in a SwiftUI app so I made some concessions and took a couple of shortcuts where needed.
4) I definitely would add more unit tests and possibly some UI tests given more time. 
5) I used `Userdefaults` instead of `CoreData` to store the favorites since all I needed was an array of IDs. With more complex data (or with more time) I definitely would utilize `CoreData` instead.
6) I had fun! Thanks for the opportunity to work on this and thanks in advance for reviewing! 
