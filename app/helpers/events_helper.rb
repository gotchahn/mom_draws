module EventsHelper
  def status(event)
    if event.completed_at.present?
      content_tag(:span, "Completado", class: ["label", "label-danger"])
    else
      content_tag(:span, "Disponible", class: ["label", "label-success"])
    end
  end

  def progress_classes(event)
    classes = ["progress-bar"]
    if event.completed_so_far < 50
      classes << "progress-bar-info"
    elsif event.completed_so_far < 70
      classes << "progress-bar-warning"
    elsif event.completed_so_far < 100
      classes << "progress-bar-danger"
    else
      classes << "progress-bar-success"
    end
  end

  def progress(event)
    content_tag(:div, class: "progress") do
      content_tag(:div, "#{event.completed_so_far}%",
        class: progress_classes(event),
        role: "progressbar",
        "aria-valuemin" => "0",
        "aria-valuemax" => "100",
        style: "width: #{event.completed_so_far}%"
      )
    end
  end
end
