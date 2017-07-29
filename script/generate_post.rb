(1..100).each do 
  post = Post.new(author: 'fcnaud', title: 'test', content: 'just for test')
  if post.save
    p 'success'
  else
    p 'failed'
  end
end
