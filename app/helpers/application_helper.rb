module ApplicationHelper

  def user_dropdown_text
    content_tag :i, '', class: 'fa fa-lg fa-navicon', title: 'Menu'
  end

  def user_dropdown_menu
    content_tag :ul, class: 'dropdown-menu' do
      content = content_tag :li, class: "dropdown-header user-dropdown-header" do
        c = content_tag :div, "Logged In As:", class: 'user-dropdown-header-offset'
        c += content_tag :div, current_user.user_identifier, class: 'user-dropdown-header-email'
        c
      end
      content += content_tag :li, "", class: 'divider'
      content += content_tag :li, link_to('Profile', account_path)
      content += content_tag :li, link_to('Logout', destroy_user_session_path, method: :delete)
    end
  end

end
