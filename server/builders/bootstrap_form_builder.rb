#Nota, tiene problemas con modelos tipo_cosa, porque las junta tipocosa
class BootstrapFormBuilder < ActionView::Helpers::FormBuilder

  def div_radio_button(method, tag_value, options = {})
    @template.content_tag(:div, 
      @template.radio_button(
        @object_name, method, tag_value, objectify_options(options)
      )
    )
  end

  def text_field_con_label(attribute, options={})
    class_name =objectify_options(options)[:object].class
    value = objectify_options(options)[:object][attribute]
#    nombre = class_name.to_s.gsub('::','_').downcase + "[" + attribute.to_s + "]"
    nombre = class_name.model_name.param_key +  "[" + attribute.to_s + "]"

    @template.content_tag(:div, @template.label_tag(attribute) +  @template.text_field_tag(nombre,value,:class => "form-control"),class: 'form-group' )
  end

  def text_field_experimento(attribute, options={})
    class_name =objectify_options(options)[:object].class
    value = objectify_options(options)[:object][attribute]
    nombre = class_name.to_s.gsub('::','_').downcase + "[" + attribute.to_s + "]"
    @template.content_tag(:div, @template.label_tag(attribute) +  @template.text_field_tag(nombre,value,:class => "form-control"),class: 'form-group' )
  end

  def select_b(attribute, tag_value)
    class_name =objectify_options(options)[:object].class
    value = objectify_options(options)[:object][attribute]
    nombre = class_name.to_s.gsub('::','_').downcase + "[" + attribute.to_s + "]"
    @template.select_tag(nombre, @template.options_for_select(tag_value,value),:class => "form-control")
  end

  def select_c(attribute, tag_value, options = {})
    class_name =objectify_options(options)[:object].class
    value = objectify_options(options)[:object][attribute]
    nombre = class_name.to_s.gsub('::','_').downcase + "[" + attribute.to_s + "]"
    @template.content_tag(:div,@template.label_tag(attribute) + 

     @template.select_tag(nombre, @template.options_for_select(tag_value,value) ,:class => "form-control"){ |c|
     content_tag(:div, content_tag(:option, c.first, :value => c.last,:class => "strong"))
})
  
  end




  def select_con_label(attribute, tag_value, options = {})
    class_name =objectify_options(options)[:object].class
    value = objectify_options(options)[:object][attribute]
    nombre = class_name.to_s.gsub('::','_').downcase + "[" + attribute.to_s + "]"
    @template.content_tag(:div,@template.label_tag(attribute) + @template.select_tag(nombre, @template.options_for_select(tag_value,value) ,:class => "form-control"), class: 'form-group')  
  end

  def file_field_con_label(attribute)
    #No usar, no funciona bien
    #@template.content_tag(:div, @template.file_field_tag(attribute, :class => "btn btn-primary"), class: 'form-group')
  end

#  def submit(attribute)
    #@template.content_tag(:span, @template.submit_tag(attribute.to_a[0][1],:class => "btn btn-primary"))
 #   @template.content_tag(:div, @template.submit_tag(attribute,:class => "btn btn-primary"), class: 'form-group')


    # @template.content_tag(:span, @template.submit_tag("Guardar",:class => "btn btn-primary"))
  #end

end
