class Task < ActiveRecord::Base
    belongs_to :category 


    def self.find_by_path(path)
        task_id = path.split('/tasks/').last.to_i
        self.all.find(task_id)
    end

    def self.render_all 
        self.all.map do |task|
            {
              id: task.id,
              text: task.text,
              category: task.category.name
            }
          end
    end


    def render_format
            {
              id: self.id,
              text: self.text,
              category: self.category.name
            }
    end
end