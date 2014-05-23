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

  def update
    group.update!(group_params)
    render json: group
  end

  def destroy
    group.destroy
    render nothing: true, status: :ok
  rescue ActiveRecord::RecordNotFound
    render nothing: true, status: :not_found
  end


  private
  def group
    @group ||= current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
