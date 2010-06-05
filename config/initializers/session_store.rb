# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_vbig_session',
  :secret      => '122c023bd59aa08ef36dc5c99a228916e8e15046b60e78cd607c1e4f426d5e5ee6a9ed17feb4cad9dbc99bf3e71544b5b12ec2e12f5c5c2696e2223d329589f1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
