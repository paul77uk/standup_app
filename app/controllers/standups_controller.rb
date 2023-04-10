class StandupsController < ApplicationController
  before_action :set_standup, only: [:show, :update, :destroy]
  
  def index
    redirect_to(root_path)
  end

  def new
    return if check_for_blank_date
    return if check_for_existance
    @standup = Standup.new
  end

  def edit
    return if check_for_blank_date
    return if check_for_existance
    @standup = Standup.find_by(
      user_id: current_user.id,
      standup_date: current_date
    )
  end

  # POST /standups
  # POST /standups.json
  def create
    @standup = Standup.new(standup_params)
    @standup.user = current_user

    if @standup.save
      redirect_back(
        fallback_location: root_path,
        notice: 'Standup was successfully created.'
      )
    else
      render :new
    end
  end

  def update
    if @standup.update(standup_params)
      redirect_back(
        fallback_location: root_path,
        notice: 'Standup was successfully updated.'
      )
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_standup
    @standup = Standup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def standup_params
    params.require(:standup).permit(:standup_date, dids_attributes:\
      [:id, :title, :_destroy], todos_attributes: [:id, :title, :_destroy],\
      blockers_attributes: [:id, :title, :_destroy])
  end

  def check_for_blank_date
    if params[:date].blank?
      redirect_to(
        update_date_path(
          date: Date.today.iso8601,
          reload_path: "/s/#{action_name}/#{Date.today.iso8601}"
        )
      ) and return true
    end
  end

  def check_for_existance
    standup = Standup.find_by(
      user_id: current_user.id, standup_date: current_date
    )
    if standup.present? && action_name == 'new'
      redirect_to(edit_standup_path(date: current_date)) and return true
    elsif standup.nil? && action_name == 'edit'
      redirect_to(new_standup_path(date: current_date)) and return true
    end
  end
end
