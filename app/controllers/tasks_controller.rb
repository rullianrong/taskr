class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_category, only: [:new_categorized_task, :create_categorized_task]
  
  # GET /tasks
  def index
    @tasks = current_user.tasks
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build
  end

  def new_categorized_task
    @task = current_user.tasks.build
  end

  def create_categorized_task
    @task = current_user.tasks.build(task_params.except(:categories))
    create_or_delete_tasks_categories(@task, params[:task][:categories])

    if @task.save
      redirect_to category_url(@category), notice: 'Task successfully added.'
    else
      render :new_categorized_task
    end
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = current_user.tasks.build(task_params.except(:categories))
    create_or_delete_tasks_categories(@task, params[:task][:categories])

    if @task.save
      redirect_to tasks_url, notice: 'Task successfully added.'
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
    # method for creating task with categories
    def create_or_delete_tasks_categories(task, categories)
      # task.todos.destroy_all
      categories = categories.strip.split(',')

      # search the users categories if each category passed to a task already exist 
      # then returns it, else it will create a new one and add it to the current task categories
      categories.each do |category|
        task.categories << current_user.categories.find_or_create_by(title: category.titleize.strip)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def set_category
      @category = current_user.categories.find(params[:category_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:body, :finish_before, :checked, :categories)
    end
end
