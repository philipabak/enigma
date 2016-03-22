module ApplicationHelper

  def main_bg
    hour = @current_time.hour
    (hour < 7 || hour > 19) ? 'sky-bg-dark.jpg' : 'sky-bg.jpg'
  end
end
