namespace :db do
    desc 'Terminate connections to the development database'
    task terminate_connections: :environment do
      db_name = 'better_fixly_development'
      ActiveRecord::Base.connection.execute <<-SQL
        SELECT pg_terminate_backend(pid)
        FROM pg_stat_activity
        WHERE datname = '#{db_name}' AND pid <> pg_backend_pid();
      SQL
    end
  end