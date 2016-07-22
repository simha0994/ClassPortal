json.extract! course_mapping, :id, :courseID, :userID, :decision, :grade, :created_at, :updated_at
json.url course_mapping_url(course_mapping, format: :json)