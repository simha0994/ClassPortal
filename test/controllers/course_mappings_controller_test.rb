require 'test_helper'

class CourseMappingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_mapping = course_mappings(:one)
  end

  test "should get index" do
    get course_mappings_url
    assert_response :success
  end

  test "should get new" do
    get new_course_mapping_url
    assert_response :success
  end

  test "should create course_mapping" do
    assert_difference('CourseMapping.count') do
      post course_mappings_url, params: { course_mapping: { courseID: @course_mapping.courseID, decision: @course_mapping.decision, grade: @course_mapping.grade, userID: @course_mapping.userID } }
    end

    assert_redirected_to course_mapping_url(CourseMapping.last)
  end

  test "should show course_mapping" do
    get course_mapping_url(@course_mapping)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_mapping_url(@course_mapping)
    assert_response :success
  end

  test "should update course_mapping" do
    patch course_mapping_url(@course_mapping), params: { course_mapping: { courseID: @course_mapping.courseID, decision: @course_mapping.decision, grade: @course_mapping.grade, userID: @course_mapping.userID } }
    assert_redirected_to course_mapping_url(@course_mapping)
  end

  test "should destroy course_mapping" do
    assert_difference('CourseMapping.count', -1) do
      delete course_mapping_url(@course_mapping)
    end

    assert_redirected_to course_mappings_url
  end
end
