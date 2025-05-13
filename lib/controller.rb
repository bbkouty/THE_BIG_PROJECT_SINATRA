require 'gossip'
require 'comment'

class ApplicationController < Sinatra::Base

    get '/' do
        erb :index, locals: {gossips: Gossip.all}
    end

    get '/gossips/new/' do
        erb :new_gossip
    end

    post '/gossips/new/' do 
        Gossip.new(params["gossip_author"], params["gossip_content"]).save
        redirect '/'
    end
    
    get '/gossips/:id' do
        @gossip = Gossip.find(params[:id].to_i)
        @comments = Comment.find_by_gossip_id(params[:id])
        erb :show
    end

    # Route pour afficher le formulaire d'édition
    get '/gossips/:id/edit/' do
        @gossip = Gossip.find(params[:id].to_i)
        erb :edit
    end

    # Route pour traiter la mise à jour du potin
    post '/gossips/:id/edit/' do
        Gossip.update(params[:id].to_i, params["gossip_author"], params["gossip_content"])
        redirect "/gossips/#{params[:id]}"
    end

    # Route pour ajouter un commentaire à un potin
    post '/gossips/:id/comment/' do
        Comment.new(params["comment_content"], params[:id]).save
        redirect "/gossips/#{params[:id]}"
    end

end