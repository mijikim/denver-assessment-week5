require "sinatra"
require "./lib/database"
require "./lib/contact_database"
require "./lib/user_database"

class ContactsApp < Sinatra::Base
  enable :sessions

  def initialize
    super
    @contact_database = ContactDatabase.new
    @user_database = UserDatabase.new

    jeff = @user_database.insert(username: "Jeff", password: "jeff123")
    hunter = @user_database.insert(username: "Hunter", password: "puglyfe")

    @contact_database.insert(:name => "Spencer", :email => "spen@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Jeff D.", :email => "jd@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Mike", :email => "mike@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Kirsten", :email => "kirsten@example.com", user_id: hunter[:id])
  end

  get "/" do
    if session[:user_id]
      @loggedinuser = @user_database.find(session[:user_id])
      erb :contacts
    else
      erb :homepage
    end
  end

  get "/login" do
    erb :login
  end

  post "/login" do
    valid_user = @user_database.all.find do |user_hash|
      user_hash[:username] == params[:username] && user_hash[:password] == params[:password]
    end
    if valid_user
      session[:user_id] = valid_user[:id]
    end
    # flash[:notice]="Welcome #{valid_user[:id]}"
    redirect "/"
  end

  post "/logout" do
    session.clear
    redirect"/"
  end

end
