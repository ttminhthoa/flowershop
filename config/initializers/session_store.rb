# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_flowershop_session',
  :secret      => '7930173868d6841475f7d2c36af8d808d02d08f85ce19ad6747dbb60bdfbc40344c735fa5bfc2bd427001e97915f529ba9889d0faadc6934f6e5429912f4f1e6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
