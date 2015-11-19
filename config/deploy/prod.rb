role :app, %w{91.221.70.59}
role :web, %w{91.221.70.59}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server '91.221.70.59', user: 'deploy', roles: %w{web app}

set :ssh_options, {
    forward_agent: true
}
