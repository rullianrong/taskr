class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  # GET /tasks
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = current_user.tasks.build(task_params.except(:categories))
    create_or_delete_tasks_categories(@task, params[:task][:categories])

    if @task.save
      redirect_to action: 'index'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    create_or_delete_tasks_categories(@task, params[:task][:categories])

    if @task.update(task_params.except(:categories))
      redirect_to @task, notice: 'Task updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task deleted.'
  end

  private
    def create_or_delete_tasks_categories(task, categories)
      task.todos.destroy_all
      categories = categories.strip.split(',')

      categories.each do |category|
        task.categories << current_user.categories.find_or_create_by(title: category.titleize.strip)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:body, :finish_before, :checked, :categories)
    end
end
