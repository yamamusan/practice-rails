class DiariesController < ApplicationController

  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  before_action :set_time, only: [:show, :index, :edit]
  around_action LoggingAction.new, only: [:index, :show, :index, :edit]

  # GET /diaries
  # GET /diaries.json
  def index
    @diaries = Diary.all.order(:title)
  end

  # GET /diaries/1
  # GET /diaries/1.json
  def show
  end

  # GET /diaries/new
  def new
    @diary = Diary.new
  end

  # GET /diaries/1/edit
  def edit
  end

  # POST /diaries
  # POST /diaries.json
  def create
    @diary = Diary.new(diary_params)
    @diary[:author] = @current_user.name

    respond_to do |format|
      if @diary.save
        format.html { redirect_to @diary, notice: '日記の作成が完了しました。' }
        format.json { render :show, status: :created, location: @diary }
      else
        format.html { render :new }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diaries/1
  # PATCH/PUT /diaries/1.json
  def update
    respond_to do |format|
      if @diary.update(diary_params)
        format.html { redirect_to @diary, notice: '日記の更新が完了しました。' }
        format.json { render :show, status: :ok, location: @diary }
      else
        format.html { render :edit }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diaries/1
  # DELETE /diaries/1.json
  def destroy
    @diary.destroy
    respond_to do |format|
      format.html { redirect_to diaries_url, notice: '日記の削除が完了しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = Diary.find(params[:id])
    end

    def set_time
      @now = Time.now
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diary_params
      params.require(:diary).permit(:title, :body)
    end
end
