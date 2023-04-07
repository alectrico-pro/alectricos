module EventsHelper
=begin
  def date_for_display(date)

    begin
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.localtime.to_s), :format => :evento)
    rescue
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.to_s), :format => :evento)
    end


  end
=end

  def date_in_time_zone(date)

    begin
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.in_time_zone.to_s), :format => :evento)
    rescue
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.to_s), :format => :evento)
    end

  end


  alias_method :date_for_display, :date_in_time_zone




  def dia_mes_en_time_zone(date)

    begin
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.in_time_zone.to_s), :format => '%B de %Y')

    rescue
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.to_s), :format => '%B de %Y')
    end

  end

  def dia_mes_año_en_time_zone(date)
    dia_mes_año = "%d de %B de %Y"
    begin
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.in_time_zone.to_s), :format => dia_mes_año)
    rescue
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.to_s), :format => dia_mes_año)
    end
  end




  def get_day(date)

    begin
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.localtime.to_s), :format => '%d')
    rescue
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.to_s), :format => '%d')
    end

  end


 def get_month(date)

    begin
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.localtime.to_s), :format => '%b')
    rescue
      fsdate = (date == nil)? date :  I18n.l( DateTime.parse(date.to_s), :format => '%b')
    end

  end



end
