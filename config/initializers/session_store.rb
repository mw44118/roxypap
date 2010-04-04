# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_roxypap_session',
  :secret      => 'aa8489706130fdf29a5bc754aa70cb0354c1feaed15fc52a2345dc70095d45984c7fe055267f62581a6832d39353f9c1ccf37481e0ae2bc30c8a39b76d6fee1b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
