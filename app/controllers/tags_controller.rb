class TagsController < ApplicationController
  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
    tag_name = params[:tag][:name]
    if Tag.find_by(name: tag_name)
        flash[:notice] = "标签已经存在"
        flash[:type]   = "danger"
    else
      @tag = Tag.new(name: tag_name)
      if @tag.save
        flash[:notice] = "标签添加成功"
        flash[:type]   = "success"
      else
        flash[:notice] = "标签保存失败"
        flash[:type]   = "warning"
      end
    end
    redirect_to tags_path
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      flash[:notice] = "标签删除成功"
    else
      flash[:notice] = "标签删除失败"
    end
    redirect_to tags_path
  end


  private
  def new_tag_params
    params.require(:tag).permit(:name)
  end
end
