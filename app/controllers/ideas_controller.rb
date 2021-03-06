# Ideas Controller
class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :set_search

  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = @search.result.order(created_at: :desc).paginate(page: params[:page],per_page: 5)
  end

  def alerted_ideas
    @ideas = @search.result
                    .where(
                      id: current_user.alerts.where(active: 1).pluck(:idea_id)
                    ).order(created_at: :desc).paginate(page: params[:page],per_page: 5)
  end

  def open_ideas
    @ideas = @search.result.order(created_at: :desc).select(&:open?).paginate(page: params[:page],per_page: 5)
  end

  def closed_ideas
   @ideas = @search.result.order(created_at: :desc).select(&:is_closed?).paginate(page: params[:page],per_page: 5)
  end

  def followed_ideas
    @ideas = @search.result.where(id: current_user.follows.pluck(:idea_id))
                    .order(created_at: :desc).paginate(page: params[:page],per_page: 5)
  end

  def not_followed_ideas
    @ideas = @search.result.where.not(id: current_user.follows.pluck(:idea_id))
                    .order(created_at: :desc).paginate(page: params[:page],per_page: 5)
  end

  def escalated_ideas
    @ideas = @search.result.order(created_at: :desc)
                    .where(final_verdict: 'Escalated').paginate(page: params[:page],per_page: 5)
  end

  def discarded_ideas
    @ideas = @search.result.order(created_at: :desc)
                    .where(final_verdict: 'Discarded').paginate(page: params[:page],per_page: 5)
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    alert = current_user.alerts.where(idea: @idea).first
    if alert.nil?
      # Create update if it doesn't exist
      Alert.create(user: current_user, idea: @idea, active: 0)
    else
      # User has seen update
      alert.active = 0
      alert.save
    end
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
    authorize! :update, @idea
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user
    @company_users = User.where(company_id: @idea.user.company_id)

    respond_to do |format|
      if @idea.save
        @company_users.each do |company_user|
          IdeaMailer.send_idea(@idea, company_user).deliver_later
        end
        # When the Idea closes, send email.
        #IdeaMailer.send_idea_closed(@idea).deliver_later(wait: @idea.open_days.minutes)        
        # Create Activity
        @idea.create_activity :create, owner: current_user
        # Create follow
        Follow.create_follow(user: current_user, idea: @idea)
        # Create alerts for everyone
        User.all.each do |user|
          Alert.create(user: user, idea: @idea, active: 1, text: 'New Idea!')
        end
        format.html {
          redirect_to @idea, notice: 'Idea was successfully created.'
        }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    authorize! :update, @idea
    respond_to do |format|
      if @idea.update(idea_params)
        # Update Activity
        @idea.create_activity :update, owner: current_user
        format.html {
          redirect_to @idea, notice: 'Idea was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    authorize! :destroy, @idea
    # Destroy idea Activity
    @idea.create_activity :destroy, owner: current_user
    @idea.destroy
    respond_to do |format|
      format.html {
        redirect_to ideas_url, notice: 'Idea was successfully destroyed.'
      }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.find(params[:id])
  end
  
  def set_search
    @search = Idea.ransack(params[:q])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def idea_params
    params.require(:idea).permit(:text, :user_id, :voting_style,
                                 :anonymous_comments, :real_time_voting,
                                 :reveal_voter_details, :open_days,
                                 :final_verdict, :force_close)
  end
end
