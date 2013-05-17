# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Server::Application.config.secret_key_base = '9e548ff3ba8ef88a6f86e746850d27334aeee2aaf9748011906d8da93abc8645ed9f6294b54f140c355c238d00e379af9e4655bf69ba49d31f66ec382f018c33'
