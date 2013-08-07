
Mime::Type.register "application/zip", :zip
require 'rubygems'
require 'zip/zip'
require 'base64'
class UsersController < ApplicationController
  # GET /users


  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb

    end
  end

  # GET /users/1

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb

    end
  end

  # GET /users/new

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb

    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
 def create
    @user = User.new(params[:user])





      if @user.save
input_filenames=Array.new

folder = "#{Rails.root}/public/uploads"

 @user.attachments.each do |name|
input_filenames << File.basename(name.image.path)

end

p input_filenames.inspect

zipfile_name = "#{Rails.root}/public/uploads/"+params[:user][:uname]+".zip"

Zip::ZipFile.open(zipfile_name, Zip::ZipFile::CREATE) do |zipfile|
 input_filenames.each do |filename|
    # Two arguments:
    # - The name of the file as it will appear in the archive
    # - The original file, including the path to find it
    zipfile.add(filename, folder + '/' + filename)
  end
end

      send_file zipfile_name, :content_type => 'application/zip',:x_sendfile=>true,:disposition => 'attachment'


                       

      else
         render action: "new" 

      end

  end
  # PUT /users/1


  def update
    @user = User.find(params[:id])


      if @user.update_attributes(params[:user])
input_filenames=Array.new

folder = "#{Rails.root}/public/uploads"

 @user.attachments.each do |name|
input_filenames << File.basename(name.image.path)

end

p input_filenames.inspect

zipfile_name = "#{Rails.root}/public/uploads/"+params[:user][:uname]+".zip"

Zip::ZipFile.open(zipfile_name, Zip::ZipFile::CREATE) do |zipfile|
 input_filenames.each do |filename|
    # Two arguments:
    # - The name of the file as it will appear in the archive
    # - The original file, including the path to find it
    zipfile.add(filename, folder + '/' + filename)
  end
end

      send_file zipfile_name, :content_type => 'application/zip',:x_sendfile=>true,:disposition => 'attachment'

      else
         render action: "edit" 

      end

  end

  # DELETE /users/1

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }

    end
  end
end
