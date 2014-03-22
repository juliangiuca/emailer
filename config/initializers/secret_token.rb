# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Emailer::Application.config.secret_key_base = 'cd64b57feb52028e4589bc87af5d02d1b86dd066c5ee07d6b98d075ca0411ab8f04c7e57b243776f63ec38e56073b077cc56b010d9501b8286410daf2b705321'
