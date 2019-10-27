class RisksController < ApplicationController
  model_object Risk
  # this is necessary if you want the project menu in the sidebar for your view
  around_action :set_time_zone
  before_action :find_project, only: [:index, :new, :create]
  before_action :find_risk, except: [:index, :new, :create]
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

  include CellsHelper

  def index
   set_index_data!
  end

  def show
    #@risk=Risk.find(params[:id])
  end

  def edit

    #@risk=Risk.find(params[:id])    
  end

  def new
    @risk=Risk.new
  end

  def create
    # TODO
    @risk = Risk.new(risk_params)
    @risk.project=@project
    if @risk.save
      # notify_changed_risks(:created, @risk)
      flash[:notice] = 'Se registró el nuevo riesgo'
      redirect_to action: 'index'
    else
      flash[:error] = 'No se pudo crear el nuevo riesgo'
      render action: 'new'
    end
  end

  def update
    # TODO
    #@risk=Risk.find(params[:id])
    #@risk.project=@project
    if @risk.update(risk_params)
      # notify_changed_risks(:created, @risk)
      flash[:notice] = 'Se actualizó el riesgo'
      redirect_to action: 'index', project_id: @project
    else
      flash[:error] = 'No se pudo actualizar el riesgo'
      render action: 'edit'
    end

  end

  def destroy
    # TODO
    #@risk=Risk.find(params[:id])
    if @risk.destroy
      flash[:notice] = 'Se eliminó el riesgo'
      redirect_to action: 'index'
    else
      flash[:error] = 'No se pudo eliminar el riesgo'
      redirect_to action: 'index'
    end
    
  end

  def risks_table_options()
    {
      project: @project
    }
  end

  def risks_filter_options()
    
    {
      project: @project
    }
  end

  
  
  def set_index_data!
    
    #@is_filtered = false#Risks::UserFilterCell.filtered? params
    #@risks = index_risks
    #@risks_table_options = risks_table_options 
    #@risks_filter_options = risks_filter_options 

    sort_columns = { 'id' => "#{Risk.table_name}.id",
                    'name' => "#{Risk.table_name}.name"
    }

    sort_init 'id', 'desc'
    sort_update sort_columns

    @risks = Risk.where(project_id:@project.id)
    .order(sort_clause)    
    .page(page_param)
    .per_page(per_page_param)
  end

  def index_risks
    #filters = params.slice(:name)
    #filters[:project_id] = @project.id.to_s

    @risks = Risk.where(project_id:@project.id)
               #.where(id: Members::UserFilterCell.filter(filters))
               #.includes(:names)
  end


  private

  def risk_params
    params.require(:risk).permit(:name,:description,:status,:impact,:probability)
    # params.require(:risk).permit(:name, :project_id)
  end

  private

  def set_time_zone
    old_time_zone = Time.zone
    zone = User.current.time_zone
    if zone.nil?
      localzone = Time.now.utc_offset
      localzone -= 3600 if Time.now.dst?
      zone = ::ActiveSupport::TimeZone[localzone]
    end
    Time.zone = zone
    yield
  ensure
    Time.zone = old_time_zone
  end

  def find_project
    @project = Project.find(params[:project_id])
    #@risk = Risk.new(risk_params)
    #@risk.project = @project
    #@meeting.author = User.current
  end

  def find_risk
    @risk = Risk.find(params[:id])    
    @project = @risk.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # def notify_changed_risks(action, changed_risk)
  #   OpenProject::Notifications.send(:risks_changed, action: action, risk: changed_risk)
  # end
end
