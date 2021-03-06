class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  #before_action :is_admin_logged_in, [:destroy]
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
    @users = User.find_by_sql("select * from users where usertype = 'Instructor'")
  end

  # GET /courses/1/edit
  def edit
    @users = User.find_by_sql("select * from users where usertype = 'Instructor'")
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_url, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to courses_url, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_enrolled_students
    @course = Course.find(params[:id])
    @users = @course.course_mappings
    @student_users = @users.select {|user| user.decision == "Accepted"}.map{|user| user.user_id}
    @students = @course.users.select {|user| @student_users.include?(user.id)}
    return @students, @course
  end

  def show_instructor_courses
    @courses = Course.find_by_sql("select * from courses where instructor= '#{current_user.name}'")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:number, :title, :description, :instructor, :status, :startdate, :enddate)
    end
end
