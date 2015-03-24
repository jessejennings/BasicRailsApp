class FavoriteMailer < ApplicationMailer
    default from: 'jessejenn@gmail.com'
    
    def new_comment(user, post, comment)
        @user = user
        @post = post
        @comment = comment
        mail(to: user.email, subject: "New comment on #{post.title}")
        
        #New Headers
        headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
        headers["In_Reply_To"] = "<post/#{post.id}@your-app-name.example>"
        headers["References"] = "<post/#{post.id}@your-app-name.example>"
        
        
    end
end
