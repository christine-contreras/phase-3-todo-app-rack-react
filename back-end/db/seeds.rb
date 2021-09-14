puts "Clearing old data..."
Category.destroy_all
Task.destroy_all

puts "Seeding Categories..."

# create categories
food = Category.create(name: 'Food')
money = Category.create(name: 'Money')
code = Category.create(name: 'Code')
misc = Category.create(name: 'Misc')
Category.create(name: 'School')

puts "Seeding tasks..."

# create tasks
# can also build this way and save 
food.tasks.build(text: "buy blueberries")
food.save

Task.create(text: 'Buy rice', category_id: food.id)
Task.create(text: 'Save a tenner', category_id: money.id)
Task.create(text: 'Build a todo app', category_id: code.id)
Task.create(text: 'Build todo API', category_id: code.id)
Task.create(text: 'Get an ISA', category_id: money.id)
Task.create(text: 'Tidy house', category_id: misc.id)


puts "Done!"