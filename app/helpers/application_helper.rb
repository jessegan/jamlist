module ApplicationHelper

    def generate_nav_bar
        if user_signed_in?
            @content = content_tag(:li, link_to("Home",home_path))
            @content << content_tag(:li, link_to("Profile","/"))
        else
            content_tag(:li, link_to("Home",root_path))
        end
    end

end
