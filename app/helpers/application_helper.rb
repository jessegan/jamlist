module ApplicationHelper

    def generate_nav_bar
        if user_signed_in?
            content_tag(:li, link_to("Home",home_path))
        else
            content_tag(:li, link_to("Home",root_path))
        end
    end

end
