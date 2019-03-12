class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
     @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    
     @pet = Pet.new(params[:pet])
     if params[:pet][:owner_id] != nil
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
     else
       @pet.owner = Owner.create(name: params[:owner][:name])
     end 
     @pet.save
     redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do 
    @owners = Owner.all 
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    
     ####### bug fix
    if !params[:pet].keys.include?("owner_id")
    params[:pet]["owner_id"] = []
    end
    #######
 
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end