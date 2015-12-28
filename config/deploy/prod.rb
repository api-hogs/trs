SERVER = "46.101.228.77"

role :app, SERVER
role :web, SERVER

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server SERVER, user: 'deploy', roles: %w{web app}

set :ssh_options, {
    forward_agent: true
}
