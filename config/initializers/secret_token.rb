# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# The secret that was in here before the environment variable has been changed

secret = ENV['PENPENCILRULER_SECRET']
if secret.length < 30
  raise "Secret token cannot be loaded"
else
  Penpencilruler::Application.config.secret_token = secret
end