class ProjectRulesController < ApplicationController
  model_object ProjectRule
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
    
    if @project_rule.update(project_rule_params)
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

    sort_init 'name', 'asc'
    sort_update sort_columns

    per_page_param=10

    @project_rules = ProjectRule
                .joins("RIGHT JOIN risk_rules ON risk_rules.id = project_rules.risk_rule_id")
                  .select('risk_rules.name,risk_rules.description,risk_rules.suggested_actions,
                        project_rules.id,project_rules.project_id,project_rules.notifications AS notifications, project_rules.status AS status')
                  .where("project_rules.project_id=?",@project.id)
                  .order(sort_clause)    
                  .page(page_param)
                  .per_page(per_page_param) 

  end  

  private

  def project_rule_params
    params.require(:project_rule).permit(:status, :notifications,:param_1,:param_2,:param_3,:param_4,:param_5)
  end

  private


  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_risk_rule
    @risk_rule = RiskRule.left_outer_joins(:project_rules).distinct
              .select('risk_rules.*,project_rules.id,project_rules.project_id,project_rules.notifications AS notifications, project_rules.status AS status')
              .where("project_rules.id=?",params[:id]).first

              
    @project_rule = ProjectRule.left_outer_joins(:risk_rule).distinct
    .select('risk_rules.name,risk_rules.description,risk_rules.suggested_actions, risk_rules.id as risk_rule_id,
    risk_rules.param_1 as name_1,risk_rules.param_2 as name_2,risk_rules.param_3 as name_3,risk_rules.param_4 as name_4,risk_rules.param_5 as name_5,
    project_rules.*')
    .where("project_rules.id=?",params[:id]).first
    
    @project = @project_rule.project
    
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
