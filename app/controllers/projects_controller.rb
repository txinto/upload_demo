class ProjectsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    hobo_show do
      if params[:style]
        send_file @project.photo.path(params[:style])
      else
        render
      end
    end
  end
  def update
    hobo_update do
      respond_to do |format|
        format.js { hobo_ajax_response }
        format.html { redirect_to @project }
      end
    end
  end  
  
end
