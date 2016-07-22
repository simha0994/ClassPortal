json.extract! course, :id, :number, :title, :description, :instructor, :status, :startdate, :enddate, :created_at, :updated_at
json.url course_url(course, format: :json)