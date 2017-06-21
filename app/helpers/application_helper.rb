module ApplicationHelper
  def gravatar_for(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}?d=retro&s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: 'img-circle')
  end
end
