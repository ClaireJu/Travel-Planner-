# Travel-Planner-
iOS App in Swift

Instructions:

In “MyPlansCollectionViewControler”-“ViewDidLoad”, I put code to clean NSDefaults each time when user start the app to make better for testing. After first launching the app, please comment the three lines code and re-run it. Then you can store your plans premaritally. Also, please run the app with connection to Internet, so it can get your location and find paths in the map.

There are five tabs. Followings are how they work.

1. Planning:  
(1) User can input information in “New Plan”, “From” and “Notes ”field.  
(2) In “To” field, user can either choose to input a location or to search by map. If user clicks “map”, the app will find scenery spots around the user and show the route from the user’s location to the spots’ locations. User can click the annotation to see the spot’s name. When clicking “Scenery” on the right top, user can see information about these spots, their names, distances and expected times. In this page, user can click “Closet Spot” on the right top and see the information about the nearest spot. Also user can choose any of these spots to be “To” location by simply clicking on the any section.  
(3) User can choose start date and end date.  
(4) In “Expense” field, user can enter estimated expense and use “+” or “-” to make adjustment. If the user enters an invalid integer, the “+” will start at 0.  
(5) When clicking on the camera icon, user can pick a photo from his photo library.  
(6) After entering information about the plan, user can click “save” to save this plan. Any field could be empty except the photo.

2. My Collections:   
(1) User can see their plans here. For each plan, it shows its attached photo and the plan name. If the user does not enter plan name before, it will show “No Plan Name”.  
(2) When clicking on a plan, the app show all information about the plan the user entered before.  
(3) If user clicks on the photo, he can zoom in and out the photo.  
(4) In My Collections, user can swipe from right to left to delete any plan.  

3. My Plans:  
Here user can swipe the screen to see all his plans just like turn the book pages. It shows the photos and names of plans.  

4. Settings:  
(1) User can change the width and height of plans shown in My Collections.  
(2) User can choose transportation. If user chooses “walk”, when finding destination by map, the span will be much smaller than that if user chooses “Drive”.

5. Expense:  
(1) In this page, it shows all the expense associated with plans the user has saved before. Under each expense bar chart is the plan’s photo. If the user adds or deletes plans, this page will change accordingly. That means the more plans the user have, the narrower each bar will be.   
(2) On the top of this page, it shows the maximum expense of the user’s plans
