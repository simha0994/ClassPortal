class CourseMappingsController < ApplicationController
  before_action :set_course_mapping, only: [:show, :edit, :update, :destroy]

  # GET /course_mappings
  # GET /course_mappings.json
  def index
    @course_mappings = CourseMapping.all
  end

  # GET /course_mappings/1
  # GET /course_mappings/1.json
  def show
  end

  # GET /course_mappings/new
  def new
    @course_mapping = CourseMapping.new
  end

  # GET /course_mappings/1/edit
  def edit
  end

  # POST /course_mappings
  # POST /course_mappings.json
  def create
    @course_mapping = CourseMapping.new(course_mapping_params)

    respond_to do |format|
      if @course_mapping.save
        format.html { redirect_to @course_mapping, notice: 'Course mapping was successfully created.' }
        format.json { render :show, status: :created, location: @course_mapping }
      else
        format.html { render :new }
        format.json { render json: @course_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_mappings/1
  # PATCH/PUT /course_mappings/1.json
  def update
    respond_to do |format|
      if @course_mapping.update(course_mapping_params)
        format.html { redirect_to @course_mapping, notice: 'Course mapping was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_mapping }
      else
        format.html { render :edit }
        format.json { render json: @course_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_mappings/1
  # DELETE /course_mappings/1.json
  def destroy
    @course_mapping.destroy
    respond_to do |format|
      format.html { redirect_to course_mappings_url, notice: 'Course mapping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def enroll
    @course = Course.find(params[:id])
    if current_user.courses.include?(@course)
      #if current_user.courses.include?()
      #@course_mapping = CourseMapping.find_by_user_id_and_course_id(current_user.id, @course)
#######################Add if statement for checking the decision whether it is requested or removed#################
      @cur_courses = current_user.course_mappings.where(:course_id => params[:id]).select(:decision)#inspect
      #render plain: @cur_courses#.course_mappings.decision
      if @cur_courses == "Removed" || @cur_courses == "Rejected"
        current_user.course_mappings.update(decision: "Requested")
        flash[:notice] = "Request sent to the instructor"
      else
        flash[:notice] = "Already Requested"
        #current_user.course_mappings.decision = "Requested"
      end
    else
      current_user.course_mappings.create(course: @course, decision: "Requested")
      flash[:notice] = "Request sent to the instructor"
    end
    redirect_to :back
  end

  def show_courses
    @show_courses = current_user.courses
    @course_mappings = current_user.course_mappings
    return @show_courses, @course_mappings
  end

  def show_requests
    @course = Course.find(params[:id])
    @requests = @course.course_mappings
    @request_users = @requests.select {|request| request.decision == "Requested"}.map{|request| request.user_id}
    @users = @course.users.select {|user| @request_users.include?(user.id)}
    return @users, @course
  end

  def accept_requests
    @course_mapping = CourseMapping.find_by_user_id_and_course_id(params[:user], params[:course])
    @course_mapping.decision = "Accepted"
    if @course_mapping.save
      flash[:notice] = "Student is enrolled into the course"
      redirect_to :back
    else
      render plain:"There were errors while saving the record"
    end 
  end

  def reject_requests
    @course_mapping = CourseMapping.find_by_user_id_and_course_id(params[:user], params[:course])
    @course_mapping.decision = "Rejected"
    if @course_mapping.save
      flash[:notice] = "Student is rejected to enroll into the course"
      redirect_to :back
    else
      render plain:"There were errors while saving the record"
    end 
  end

  def show_enrolled_students
    @course = Course.find(params[:id])
    @users = @course.course_mappings
    @student_users = @users.select {|user| user.decision == "Accepted"}.map{|user| user.user_id}
    @students = @course.users.select {|user| @student_users.include?(user.id)}
    return @students, @course
  end

  def remove_students
    @course_mapping = CourseMapping.find_by_user_id_and_course_id(params[:user], params[:course])
    @course_mapping.decision = "Removed"
    if @course_mapping.save
      flash[:notice] = "Student is removed from the course"
      redirect_to :back
    else
      render plain:"There were errors while saving the record"
    end 
  end

  def grades
    @course_mapping = CourseMapping.find_by_user_id_and_course_id(params[:course_mapping][:user_id], params[:course_mapping][:course_id])
    @course_mapping.grade = params[:course_mapping][:grade]
    if @course_mapping.save
      flash[:notice] = "Grade is posted"
      redirect_to :back
    else
      render plain:"There were errors while saving the record"
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_mapping
      @course_mapping = CourseMapping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_mapping_params
      params.require(:course_mapping).permit(:courseID, :userID, :decision, :grade)
    end
end
