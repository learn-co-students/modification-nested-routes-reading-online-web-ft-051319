module PostsHelper
  def author_id_field(post)
    if @post.author.nil?
      f.collection_select :author_id, Author.all, :id, :name
    else
      hidden_field_tag "post[author_id]", post.author_id
    end
  end
end
