# UniVerse Social Network App
This project is a social network app designed for Ashesi students. The app has six main functionalities 
and was developed using REST API concepts, serverless and cloud technologies, and the flutter framework

# Stack
* Frontend - Flutter
* Backend - Python/Flask API
* Database and Hosting - Firebase

# Functionalities
## Create Profile/Sign Up Page
Allows a user to create a profile by submitting their student ID number, name, email, date of birth, year
group, major, whether or not they have campus residence, their best food, and their best
movie.

## Edit User Profile Page
Allows a user to edit all their profile information except their student ID, name,
and email.

## View Profile Page
Allows a user to view the profile information of another user.

* Development of profile functionalities follow the REST architectural style.
That is, there are appropriate REST APIs at the backend. The profile details are 
stored in an appropriate database

## Create Post Page
Allows a user to create a post that is updated on the feed page in real time

## Feed Page
Allows a user to view the posts of all users on the network. The page is updated in real time as other users create posts

## Mailer function
Sends an email notification to all users on the platform whenever a new post is made. The email contains the name of the
user that made the post and a direct link to view the post

## Other
* A Login page and its associated funcitonality (logout) is included to track which user is using the app at a given time.
This allows for user specific information to be displayed.


Provide a page or section which shows all the posts that users have made in descending
order of time. This page should update in real-time. That is, if a user is on the page when
another user makes a post, the post should immediately appear at the top of the feed.