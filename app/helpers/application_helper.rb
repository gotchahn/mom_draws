module ApplicationHelper
  def error_messages_for(errors)
    if errors.any?
      render partial: 'shared/error_messages_for',
        locals: {full_messages: errors.full_messages, error_message: flash[:error]}
    end
  end

  def current_action?(*action_strings)
    cur_action = "#{controller.controller_name}##{controller.action_name}"
    action_strings.include?(cur_action)
  end

  def nice_date(date)
    date.strftime("%d/%m/%Y %I:%M %p")
  end

  def lempiras(number)
    number_to_currency(number)
  end
end
