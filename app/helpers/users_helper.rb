module UsersHelper

  def user_avatar_width_for_size(size)
    case size
    when :xs then 16
    when :sm then 32
    when :md then 48
    when :lg then 96
    else size
    end
  end

  def user_avatar_tag(user, version= :md, opts={})
    width = user_avatar_width_for_size(version)
    img_class = "media-object avatar-#{width}"

    img = 
      if user.avatar_url?
        image_url = user.avatar_url.url
        image_tag(image_url, class: img_class)
      else
        image_url = LetterAvatar.generate(user.avatar_name, width).gsub('public/', '/')
        image_tag(image_url, class: img_class)
      end

    if opts[:link]!=false
      link_to(raw(img), user_path(user))
    else
      raw(img)
    end

  end
end
