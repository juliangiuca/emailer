class Api::V1::GroupsController < Api::ApiController

  def index
    render json: current_user.groups.to_a
  end

  def show
    render json: group
  end

  def create
    render json: current_user.groups.create!(request_body)
  end


  private
  def group
    @group ||= current_user.groups.find(params[:id])
  end
end
