class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    #find question that corresponds to id in the params passed to show, assign it to @question
     @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    # call Question.new to create new instance of Question
    @question = Question.new
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]

# nb. video solution refactored the above into:
    # @question = Question.new(params.require(:question).permit(:title, :body, :resolved))

    # if successfully save post to database, display success message
    if @question.save
      # assign value to flash[:notice]
      flash[:notice] = "Question was saved."
      redirect_to @question     #directs user to post show view
    else
      flash.now[:alert] = "There was an error saving the question. Please try again."
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]

    if @question.save
      flash[:notice] = "Question was updated."
      redirect_to @question
    else
      flash.now[:alert] = "There was an error saving the question. Please try again."
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if @question.destroy
      flash[:notice] = "\"#{@question.title}\" was deleted successfully."
      redirect_to questions_path
    else
      flash.now[:alert] = "There was an error deleting the question."
      render :show
    end
  end

end
