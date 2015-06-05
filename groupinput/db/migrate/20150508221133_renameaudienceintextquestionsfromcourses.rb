class Renameaudienceintextquestionsfromcourses < ActiveRecord::Migration
  def change
  	rename_column :textquestions, :course_id, :audience_id
  end
end
