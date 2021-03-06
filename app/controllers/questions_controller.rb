class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_author!, only: [:new, :create, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
    @authors = Author.all
    len = 0
    @questions.each do |question|
      0.upto(question.content.length - 1) do |i| 
        len += question.content[i].ord > 127 ? 2 : 1 
        if len >= 20
          question.content = question.content[0..i] + '   ...'
          break
        end
      end
      question.content += len < 20 ? ' ' * (20 - len) : ''
      len = 0
      0.upto(question.answer.length - 1) do |i|
        len += question.answer[i].ord > 127 ? 2 : 1
        if len >= 20
          question.answer = question.answer[0..i] + '   ...'
          break
        end
        question.answer += len < 20 ? ' ' * (20 - len) : ''
      end
      len = 0
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @author = Author.find(@question.author_id)
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.author_id = current_author.id
    @question.team = current_author.team
    @question.position = current_author.position
  end

  # GET /questions/1/edit
  def edit
    if @question.author_id != current_author.id
      redirect_to '/'
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.author_id = current_author.id
    @question.team = current_author.team
    @question.position = current_author.position
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @question.author_id = current_author.id
    @question.team = current_author.team
    @question.position = current_author.position
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:team, :position, :content, :answer, :difficulty, :author_id)
  end
end
