require 'sinatra'
require 'pony'


class Emailer < Sinatra::Base

  post '/contact' do
    return error if params[:email].nil? || params[:name].nil? || params[:message].nil?
    Pony.mail(:to=>ENV['EMAIL_TO'], :from=>ENV['EMAIL_FROM'], :subject=>"[spparker.com] Message from #{params[:email]}", :body => params[:message])
    redirect '/contact.html?success=true'
  end

  def error
    redirect '/contact.html?errors=true'
  end
end
