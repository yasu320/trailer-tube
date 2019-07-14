set :app_eip, "3.113.97.130"

role :app, "admin@#{fetch(:app_eip)}"
role :web, "admin@#{fetch(:app_eip)}"
role :db, "admin@#{fetch(:app_eip)}"
