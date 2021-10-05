module ApplicationHelper

  def user_avatar(user, size=40)
    if user.avatar.attached?
      user.avatar
    else
      "default_profile.jpg"
    end
  end

  def post_image(post)
    if post.image.attached? 
      post.image 
    else
      ""
    end
  end
end
