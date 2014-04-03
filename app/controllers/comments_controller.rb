class CommentsController < ApplicationController
  def find_commentable
    p params.to_s
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end 

  def index
    @commentable = find_commentable
    @comments = @commentable.comments
  end

  def create
    p params.class
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Successfully saved comment."
      redirect_to :id => nil
    else
      render :action => 'new'
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end  

  
end
