class RobotsController < ApplicationController

  def index
    @robots = Robot.all
  end

  def new
    @robot = Robot.new
  end

  def create
    @robot = Robot.create(robot_params)
    redirect_to robots_path
  end

  def destroy
    @robot = Robot.find(params[:id])
    @robot.destroy
    flash[:success] = "Your robo was terminated."
    redirect_to robots_path
  end

  def edit
    @robot = Robot.find(params[:id])
  end

  def update
    @robot = Robot.find(params[:id])
    @robot.update(robot_params)
    redirect_to robots_path
  end
  
  def show
    @robot = Robot.find(params[:id]) 
  end

  private

  def robot_params
    params.require(:robot).permit(:name, :model, :price, :rentals)
  end

end