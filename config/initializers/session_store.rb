# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_security_test_session',
  :secret      => '6523092e11b3590b5495494a7145b603c1a91621b7cb2a0713775759fe3742df9dfeedaaa49db4811dee53180fb28fbd9c1401d5c4a1cebd5a0b44a76a24df77'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
