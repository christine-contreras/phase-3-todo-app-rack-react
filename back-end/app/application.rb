require 'pry'
require 'json'

class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/tasks/) && req.delete?
      # abstracted out
      task = Task.find_by_path(req.path)

      if task && task.destroy 
        return [200, { 'Content-Type' => 'application/json' }, [ {:message => "task successfully deleted", task: task}.to_json ]]
      else
        return [404, { 'Content-Type' => 'application/json' }, [ {:message => "task not found"}.to_json ]]
      end #destroy if statement


    elsif req.path.match(/tasks/) && req.post?
      
      hash = JSON.parse(req.body.read)
      category = Category.find_by_name(hash["category"])
      #task = category.tasks.build(text: hash["text"]) 
      task = Task.create(text: hash["text"], category_id: category.id)

      # abstract out
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "task successfully added", task: task.render_format}.to_json ]]
      
      # if task.save
      #   return [200, { 'Content-Type' => 'application/json' }, [ {:message => "task successfully added", task: task}.to_json ]]
      # else
      #   return [422, { 'Content-Type' => 'application/json' }, [ {:error => "task not  added"}.to_json ]]
      # end


    elsif req.path.match(/tasks/) && req.get?
      # abstracted out
      tasks = Task.render_all

      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "task successfully requested", tasks: tasks}.to_json ]]

    else
      resp.write "Path Not Found"

    end #routes if statement

    resp.finish
  end #call

end #application 


# GET /tasks - show all tasks
# PUTS /tasks - create a new task
# DELETE /tasks/:id - delete task