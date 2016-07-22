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
      flash[:notice] = "Already Requested"
    else
      current_user.course_mappings.create(course: @course, decision: "Requested")
      flash[:notice] = "Request sent to the instructor"
    end
    redirect_to :back
  end

  def show_courses
    
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
