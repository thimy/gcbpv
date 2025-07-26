atom_feed do |post|
  post.title("posts Index")
  post.updated((@posts.first.created_at))
  
  @posts.each do |post|
    post.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.content, type: 'html')
  
      entry.author do |creator|
        author.name("GCBPV")
      end
    end
  end
end
