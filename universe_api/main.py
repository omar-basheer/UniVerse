import datetime
import firebase_admin, smtplib
from firebase_admin import firestore
from firebase_admin import credentials
from flask import Flask, request, jsonify, json, redirect, render_template
from email.mime.text import MIMEText
from flask_cors import CORS


# setup firestore databas

cred = credentials.Certificate("my-cloud-api-382615-firebase-adminsdk-6d5bf-eb61d58e29.json")
firebase_admin.initialize_app(cred)

# firebase_admin.initialize_app(cred, {
#     'projectId': 'my-cloud-api-382615'
# })
db = firestore.client()

# define functions for api

app = Flask(__name__)
# from app import  mail

CORS(app)


@app.route('/create-profile', methods=['POST'])
def create_profile():
    # get profile data from form data
    profile = json.loads(request.data)
    profile_id = profile['id']
    

    # create empty doc object for new profile
    new_profile = db.collection('profiles').document(profile_id)
    # get the profile info for this id
    profile_doc = new_profile.get()

    if profile_doc.exists:
        return jsonify({'success': False, 'message': 'Student with this id already exists '})
    else:
        profile['posts'] = []
        new_profile.set(profile)
        profiles = db.collection('profiles').get()
        # profiles_list = [prof.to_dict() for prof in profiles]
        return jsonify({'success': True, 'message': 'created user profile  for user '+ profile_id + ' successfully'})
        # return jsonify(profiles)


@app.route('/login', methods=['POST'])
def login_profile():
    # get login credentials from form data
    log_cred = json.loads(request.data)
    login_id = log_cred['id']
    password = log_cred['password']

    # create empty doc object for profile
    profile = db.collection('profiles').document(login_id)
    # get the profile info for this id
    profile_doc = profile.get()

    if profile_doc.exists:
        # print(profile_doc.to_dict())
        if profile_doc.to_dict()['password'] == password:
            print('logged student '+ login_id + ' in successfully')
            student_mail = profile_doc.to_dict()['this_student']['email']
            fname = profile_doc.to_dict()['this_student']['first_name']
            lname= profile_doc.to_dict()['this_student']['last_name']
            print(student_mail)
            # redirect('/feed')
            return jsonify({'success': True, 'message': 'logged student '+ login_id + ' in successfully', 'email': student_mail, 'fname': fname, 'lname': lname})
        else:
            print('incorrect id or password')
            # redirect('/login')
            return jsonify({'success': False, 'message': 'Incorrect id or password'})

    else:
        return jsonify({'success': False, 'message': 'Incorrect id or password'})


@app.route('/view-profile', methods=['GET'])
def view_profile():
    # get id of student whose profile we want to view
    profile_id = request.args.get('id')

    # id verification is unnecessary since id will be obtained on profile button click

    profile = db.collection('profiles').document(profile_id)
    profile_doc = profile.get()
    if profile_doc.exists:
        profile_doc = profile.get().to_dict()
        student_posts = profile_doc['posts']
        student_info = profile_doc['this_student']
        return jsonify({"success": True, "info": {"posts": student_posts, "profile": student_info}})

    else:
        # probably have to redirect
        return jsonify({'success': False, 'message': 'Student with id ' + profile_id + ' no longer exists. this might be because their account has been deleted '})


@app.route('/edit-profile', methods=['PATCH'])
def edit_profile():
    # get id of student whose profile we are going to edit
    profile_id = request.args.get('id')
    new_profile = json.loads(request.data)

    # get current user data from db
    curr_profile = db.collection('profiles').document(profile_id)
    curr_profile_doc = curr_profile.get().to_dict()
    curr_student = curr_profile_doc['this_student']

    curr_student.update({
        'major': new_profile['major'],
        'year': new_profile['year'],
        'residence': new_profile['residence'],
        'best_food': new_profile['best_food'],
        'best_movie': new_profile['best_movie'],
        })
    
    # save changes to the database
    curr_profile.update({'this_student': curr_student})

    return jsonify({'success': True, 'message': 'Profile updated succesfully'})

@app.route('/get-profiles', methods=['GET'])
def get_profile():
    users = []
    profiles = db.collection('profiles').get()

    for profile in profiles:
        profile_data = profile.to_dict()
        user_data = profile_data.get('this_student')

        if user_data:
            user = {
                'email': user_data.get('email'),
                'name': user_data.get('first_name').lower() + ' ' + user_data.get('last_name').lower()
            }
            users.append(user)
    return jsonify(users)
            

@app.route('/create-post', methods=['PATCH'])
def create_post():
    message = json.loads(request.data)
    student_id = message['id']
    post_message = message['message']

    # since user is already logged in at this point, do we still need to check if they are logged in

    # first let's add post to user's posts

    profile = db.collection('profiles').document(student_id)
    profile_doc = profile.get().to_dict()
    # print(profile_doc)

    # get list of posts by this students
    student_posts = profile_doc['posts']
    # get time of post
    time = datetime.datetime.now()
    timestamp = time.strftime('%Y-%m-%d %H:%M:%S')

    # add timestamp alone to list of students posts
    student_posts.append(timestamp)
    profile.update({'posts': student_posts})

    # now the feeds
    # create a new collection for the feeds
    feeds = db.collection('feeds').document(timestamp)

    # create post obj to add to feeds
    student_mail = profile_doc['this_student']['email']
    post_obj = {
        'email': student_mail,
        'id': student_id,
        'message': post_message,
        'timestamp': timestamp
    }

    # add post object to feeds
    feeds.set(post_obj)

    # send mail to all users on feed that user x has posted
    # get students name for sending notification mail
    first_name = profile_doc['this_student']['first_name']
    last_name = profile_doc['this_student']['last_name']
    student_name = first_name + ' ' + last_name
    gen_message = 'New Post by ' + student_name + '!'
    gen_subject = student_name + ' just posted on Universe! Click the link below to access the feed and join the convo: ' + 'https://universeapp-4bb24.web.app/#/'

    all_users = db.collection('profiles').get()
    for user in all_users:
        # print(user.to_dict()['this_student']['email'])
        receiver = user.to_dict()['this_student']['email']
        # send_email(receiver, gen_subject, gen_message )
        print('mail sent')

    return jsonify({'success': True, 'message': 'post with id ' + timestamp + ' by student ' + student_mail + ' created successfully'})


@app.route('/feeds', methods=['GET'])
def view_feeds():
    # the only thing we might want to do here is check if you're logged in
    # if you are,
    feed_id = request.args.get('timestamp')
    print(feed_id)
    if (feed_id):
        feed = db.collection('feeds').document(feed_id).get()
        if feed.exists:
            return jsonify(feed.to_dict())
        else:
            return jsonify({'error': 'Feed not found'})
    else:
        all_feeds = db.collection('feeds').get()
        feeds_list = [this_feed.to_dict() for this_feed in all_feeds]
        return jsonify(feeds_list)
    

# def sendEmails(email):
#     all_emails = db.collection("students")
#     email_list = []
#     for student_email in all_emails.get():
#         student_email = student_email.to_dict()["email"]
#         email_list.append(student_email)
#         student_mail = email
#     student_ref = db.collection("students").document(student_mail)
#     student_details = students.document(student_mail).get().to_dict()
#     student_fullname = student_details["first_name"] + " "+ student_details["last_name"]
#     for email in email_list:
        
#         new_email = mail_ref.document()
#         new_email.set(
#             {
#              "to":email,
#              "message":{
#                 "subject": "New post by " + student_fullname + "!",
#                 "text":  "Login into CampusBuzz to see the post" 
#              }
#             }
#         )




def send_email(recipient, subject, body):
    # Email account credentials
    email_address = 'universe.ashesi@gmail.com'
    # email_password = 'vrbgplevrrgxevkx'
    email_password = 'rduwpbhzledgsjpt'

    # Set up email message
    message = MIMEText(body)
    message['Subject'] = subject
    message['From'] = email_address
    message['To'] = recipient

    # Connect to SMTP server
    smtp_server = 'smtp.gmail.com'
    smtp_port = 587
    smtp_connection = smtplib.SMTP(smtp_server, smtp_port)
    smtp_connection.starttls()
    smtp_connection.login(email_address, email_password)

    # Send email
    # smtp_connection.set_debuglevel(1)
    smtp_connection.sendmail(email_address, recipient, message.as_string())
    smtp_connection.quit()


# universe_app.run(debug=True)
app.run(debug=True)




