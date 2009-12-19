# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tweet+expand_session',
  :secret      => 'be2a6b39632dd9a34e15f6409b68cdea9f6b58e7af9bcccc539fe4b164ce1932e9bc3ec54912c902c824c11c09fe8d39cfb9c6b35cd1cfef6d347f86269627fc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
