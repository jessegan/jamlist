module ApplicationHelper

    def generate_nav_bar
        if user_signed_in?
            @content = content_tag(:li, link_to("Home",home_path, class: "black-text"))
            @content << content_tag(:li, link_to("Profile",current_user, class: "black-text"))
        else
            content_tag(:li, link_to("Login","/login", class: "black-text"))
        end
    end

end
