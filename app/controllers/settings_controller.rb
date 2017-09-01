class SettingsController < ApplicationController

  before_action :auth_user
  before_action :set_user
  
  def uploader_avatar
  end
  def update_avatar
    @user.avatar_url = params[:user][:avatar_url]
    if @user.save
      flash[:notice] = "上传头像成功"
      redirect_to user_path(@user)
    else
      flash[:notice] = "上传头像失败"
      render :uploader_avatar
    end
  end

  private
  def set_user
    @user = current_user
  end

end
