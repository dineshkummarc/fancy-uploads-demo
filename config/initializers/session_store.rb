# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fancy_uploads_session',
  :secret      => 'a257c4d947171ce9ef867da27a99c073ecdff422b67a46c081ee5c6efadb5d90e5267beeecffb60575f894cdb4e6a7c230868a757c4819be5326de3f0429959d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
