# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Comment.all.each do |comment|
  user = User.find_by(username: comment.commenter)
  if user
    comment.user_id = user.id
    p comment.user_id
    p comment.commenter
    comment.save
  end
end

