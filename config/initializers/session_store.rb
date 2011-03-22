# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_MeTooexample_session',
  :secret      => 'fdbd886ca4ea06d4613ba168c652099fb7dd4ec3fe27ef7efd0335090705b5c212c357a0cad07b2c61778e0e8448c447640c3a842340e3f0cc7ee8a073b4791c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
