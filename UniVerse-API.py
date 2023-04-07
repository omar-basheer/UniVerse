import datetime

import firebase_admin
from firebase_admin import firestore
from firebase_admin import credentials
from flask import Flask, request, jsonify, json, redirect, render_template

# setup firestore database
cred = credentials.Certificate("my-cloud-api-382615-firebase-adminsdk-6d5bf-eb61d58e29.json")
firebase_admin.initialize_app(cred, {
    'projectId': 'my-cloud-api-382615'
})
db = firestore.client()

# define functions for api

universe_app = Flask(__name__)


@universe_app.route('/create-profile', methods=['POST'])
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
        new_profile.set(profile)
        profiles = db.collection('profiles').get()
        profiles_list = [prof.to_dict() for prof in profiles]
        return jsonify(profiles_list)


@universe_app.route('/login', methods=['POST'])
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
        print(profile_doc.to_dict())
        if profile_doc.to_dict()['password'] == password:
            print('logged student '+ login_id + ' in successfully')
            # redirect('/feed')
            return jsonify({'success': True, 'message': 'logged student '+ login_id + ' in successfully'})
        else:
            print('incorrect id or password')
            # redirect('/login')
            return jsonify({'success': False, 'message': 'incorrect id or password'})

    else:
        return jsonify({'success': False, 'message': 'Student with this id already exists '})


@universe_app.route('/view-profile', methods=['GET'])
def view_profile():
    # get id of student whose profile we want to view
    profile_id = request.args.get('id')

    # id verification is unnecessary since id will be obtained on profile button click
    # redirect to view profile page?

    profile = db.collection('profiles').document(profile_id)
    profile_doc = profile.get()
    if profile_doc.exists:
        profile_doc = profile.get().to_dict()
        student_posts = profile_doc['posts']
        student_info = profile_doc['this_student']
        return jsonify([student_posts, student_info])

    else:
        # probably have to redirect
        return jsonify({'success': False, 'message': 'Student with id ' + profile_id + ' no longer exists. this might be because their account has been deleted '})


@universe_app.route('/create-post', methods=['PATCH'])
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
        'message': post_message,
        'timestamp': timestamp
    }

    # add post object to feeds
    feeds.set(post_obj)

    all_feeds = db.collection('feeds').get()
    feeds_list = [this_feed.to_dict() for this_feed in all_feeds]
    return jsonify(feeds_list)


universe_app.run(debug=True)





