class RisksController < ApplicationController
  model_object Risk
  # this is necessary if you want the project menu in the sidebar for your view
  around_action :set_time_zone
  before_action :find_project#, only: [:index, :new, :create]
  before_action :authorize, except: [:index]

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
    @risk=Risk.find(params[:id])
  end

  def edit
    @risk=Risk.find(params[:id])    
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
      flash[:notice] = 'Created new risk'
      redirect_to action: 'index'
    else
      flash[:error] = 'Cannot create new risk'
      render action: 'new'
    end
  end

  def update
    # TODO
    @risk=Risk.find(params[:id])
    
    if @risk.update(risk_params)
      # notify_changed_risks(:created, @risk)
      flash[:notice] = 'Updated risk'
      redirect_to @risk
    else
      flash[:error] = 'Cannot update new risk'
      render action: 'edit'
    end
  end

  def destroy
    # TODO
    @risk=Risk.find(params[:id])
    if @risk.destroy
      flash[:notice] = 'Deleted risk'
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
    
    @is_filtered = false#Risks::UserFilterCell.filtered? params
    @risks = index_risks
    @risks_table_options = risks_table_options 
    @risks_filter_options = risks_filter_options 
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
    #@risk = Risk.new
    #@meeting.project = @project
    #@meeting.author = User.current
  end


  # def notify_changed_risks(action, changed_risk)
  #   OpenProject::Notifications.send(:risks_changed, action: action, risk: changed_risk)
  # end
end
