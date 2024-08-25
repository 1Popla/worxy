class OpinionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:create, :new]

  def new
    @opinion = current_user.given_opinions.find_by(ratee_id: @user.id) || Opinion.new
  end

  def create
    @opinion = current_user.given_opinions.build(opinion_params)
    @opinion.ratee_id = @user.id

    if @opinion.save
      redirect_to @user, notice: "Opinia została pomyślnie dodana."
    else
      flash.now[:opinion_alert] = @opinion.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def opinion_params
    params.require(:opinion).permit(:stars, :comment)
  end
end
