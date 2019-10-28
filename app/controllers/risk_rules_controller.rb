class RiskRulesController < ApplicationController
  model_object RiskRule
  # this is necessary if you want the project menu in the sidebar for your view
  before_action :find_project, only: [:index, :new, :create]
  before_action :find_risk_rule, except: [:index, :new, :create]
  before_action :authorize, except: [:index]

  helper :sort
  include SortHelper

  helper :watchers
  include WatchersHelper
  include PaginationHelper

  include Pagination::Controller
  paginate_model User
  search_for User, :search_in_project
  search_options_for User, lambda { |*| { project: @project } }

  def index
   set_index_data!
  end

  def show
    #@risk_rule=RiskRule.find(params[:id])
  end

  def edit
    
  end

  def new

  end

  def create
    
  end

  def update
    # TODO
    @project_rule=ProjectRule.find(params[:id])
    
    if @project_rule.update(risk_rule_params)
      flash[:notice] = 'Se configuró la regla'
      redirect_to action: 'index', project_id: @project
    else
      flash[:error] = 'No se pudo configurar la regla'
      render action: 'edit'
    end
  end

  def destroy
    
  end

  
  
  def set_index_data!
    sort_columns = { 
      'name' => "#{RiskRule.table_name}.name",
      'status' => "#{ProjectRule.table_name}.status",
      'notifications' => "#{ProjectRule.table_name}.notifications",
      'created_at' => "#{RiskRule.table_name}.created_at"
    }

    sort_init 'id', 'asc'
    sort_update sort_columns

    per_page_param=10

    @risk_rules = RiskRule.left_outer_joins(:project_rules).distinct
                  .select('risk_rules.*,project_rules.project_id,project_rules.notifications AS notifications, project_rules.status AS status')
                  .where("project_rules.project_id=?",@project.id)
                  .order(sort_clause)    
                  .page(page_param)
                  .per_page(per_page_param) 

  end

  private

  def risk_rule_params
    params.require(:risk_rule).permit(:status, :notifications)
  end

  private


  def find_project
    @project = Project.find(params[:project_id])
    #@risk_rule = Risk.new
    #@meeting.project = @project
    #@meeting.author = User.current
  end

  def find_risk_rule
    @risk_rule = RiskRule.left_outer_joins(:project_rules).distinct
              .select('risk_rules.*,project_rules.id,project_rules.project_id,project_rules.notifications AS notifications, project_rules.status AS status')
              .where("project_rules.id=?",params[:id]).first

    @project_rule = ProjectRule.left_outer_joins(:risk_rule).distinct
    .select('risk_rules.name,risk_rules.description,risk_rules.suggested_actions, risk_rules.id as risk_rule_id,project_rules.*')
    .where("project_rules.id=?",params[:id]).first
    
    @risk_rule_parameters=MasterRuleParameter.where('risk_rule_id=?',@risk_rule.id)
    @project = @project_rule.project
    
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
