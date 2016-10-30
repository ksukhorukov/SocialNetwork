namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@epam.com",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  threads = []
  puts Benchmark.measure {
    (0...1000).step(10) do |i|
      #threads << Thread.new do 
        (i...i+10).each do |j|
          name  = Faker::Name.name
          email = "example-#{j+1}@epam.org"
          password  = "password"
          begin
            User.create!(name:     name,
                         email:    email,
                         password: password,
                         password_confirmation: password)
          ensure
            #ActiveRecord::Base.clear_active_connections!
          end
        end
      #end
    end
    #threads.map(&:join)
  }
end

def make_microposts
  users = User.all
  threads = []
  puts Benchmark.measure {
    (0...users.count).step(10) do |i|
     #threads << Thread.new do 
        (i...i+10).each do |j|
          unless users[j].nil?
            50.times do
              content = Faker::Lorem.sentence(5)
              begin
                users[j].microposts.create!(content: content)
              ensure
                #ActiveRecord::Base.clear_active_connections!
              end
            end
          end
        end
     #end
    end
  }
  #threads.map(&:join)
end

def make_relationships
  users = User.all
  threads = []
  puts Benchmark.measure {
    (0...users.count).step(10) do |i|
      #threads << Thread.new do 
        (i..i+10).each do |j|
          unless users[j].nil?
            100.times do 
              begin
                users[j].follow!(users[rand(users.count-1)])
              ensure
                #ActiveRecord::Base.clear_active_connections!
              end
            end
          end
        end
      #end
    end
  }
  #threads.map(&:join)
end