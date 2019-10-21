class RiskRulesController < ApplicationController
  model_object RiskRule
  # this is necessary if you want the project menu in the sidebar for your view
  before_action :find_project#, only: [:index, :new, :create]
  before_action :authorize, except: [:index]

  def index
   set_index_data!
  end

  def show
    @risk_rule=RiskRule.find(params[:id])
  end

  def edit
    @risk_rule=RiskRule.left_outer_joins(:project_rules).distinct
              .select('risk_rules.*,project_rules.id,project_rules.project_id,project_rules.notifications AS notifications, project_rules.status AS status')
              .where("project_rules.id=?",params[:id]).first
  end

  def new

  end

  def create
    
  end

  def update
    # TODO
    @risk_rule=RiskRule.find(params[:id])
    
    if @risk_rule.update(risk_rule_params)
      # notify_changed_risks(:created, @risk_rule)
      flash[:notice] = 'Updated risk'
      redirect_to @risk_rule
    else
      flash[:error] = 'Cannot update new risk'
      render action: 'edit'
    end
  end

  def destroy
    
  end

  
  
  def set_index_data!
    
    @risk_rules = index_risk_rules

  end

  def index_risk_rules


    @risk_rules = RiskRule.left_outer_joins(:project_rules).distinct
                  .select('risk_rules.*,project_rules.project_id,project_rules.notifications AS notifications, project_rules.status AS status')
                  .where("project_rules.project_id=?",@project.id)
                  .order("risk_rules.id ASC")
    

  end

  private

  def risk_rule_params
    #params.require(:risk).permit(:name,:description,:status,:impact,:probability)
  end

  private


  def find_project
    @project = Project.find(params[:project_id])
    #@risk_rule = Risk.new
    #@meeting.project = @project
    #@meeting.author = User.current
  end

end
