class RisksController < ApplicationController
  # this is necessary if you want the project menu in the sidebar for your view
  # before_filter :find_optional_project, only: :index

  def index
    @risks = Risk.all

    render layout: true
  end

  def new
    @risk = Risk.new
  end

  def create
    # TODO
    @risk = Risk.new(risk_params)
    if @risk.save
      # notify_changed_risks(:created, @risk)
      flash[:notice] = 'Created new risk'
      redirect_to action: 'index'
    else
      flash[:error] = 'Cannot create new risk'
      render action: 'new'
    end
  end

  private

  def risk_params
    params.require(:risk).permit(:name)
    # params.require(:risk).permit(:name, :project_id)
  end

  # def notify_changed_risks(action, changed_risk)
  #   OpenProject::Notifications.send(:risks_changed, action: action, risk: changed_risk)
  # end
end
