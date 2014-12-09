# #The environment variable DATABASE_URL should be in the following format:
# # => postgres://{user}:{password}@{host}:{port}/path
# configure :production, :development, :test do
#   db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
#   puts db
#   puts db.host
#   puts db.user
#   puts db.path
 
#   ActiveRecord::Base.establish_connection(
#       :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
#       :host     => db.host,
#       :username => db.user,
#       :password => db.password,
#       :database => db.path[1..-1],
#       :encoding => 'utf8'
#   )
# end

#puts ActiveRecord::Base.connection.current_database