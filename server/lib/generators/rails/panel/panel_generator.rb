class Rails::PanelGenerator < Rails::Generators::NamedBase
  def create_panel_file
    create_file "app/views/#{class_name.to_s.deconstantize.downcase}/#{plural_name}/_panel.html.haml", <<-FILE
=render 'main_menu'
%h1 Panel de #{class_name.to_s}
%section.row.text-center.placeholders
  .col-6.col-sm-3.placeholder
    .nav-item.nav-link= link_to('<span class="glyphicon glyphicon-plus"></span> <span class="glyphicon map-marker"></span> #{class_name.to_s}'.html_safe,new_#{plural_name.singularize}_path)
    .text-muted Agrega un registro
    FILE
  end

end
