module ApplicationHelper
  def human_readable_priority(priority)
    case priority
    when "no_priority"
      I18n.t("helpers.priority.no_priority")
    when "high_priority"
      I18n.t("helpers.priority.high_priority")
    when "medium_priority"
      I18n.t("helpers.priority.medium_priority")
    when "low_priority"
      I18n.t("helpers.priority.low_priority")
    else
      I18n.t("helpers.priority.unknown")
    end
  end

  def human_enum_name(enum_name, enum_key)
    translations = {
      "helpers.booking.statuses" => {
        "pending" => I18n.t("helpers.booking.statuses.pending"),
        "confirmed" => I18n.t("helpers.booking.statuses.confirmed"),
        "completed" => I18n.t("helpers.booking.statuses.completed"),
        "cancelled" => I18n.t("helpers.booking.statuses.cancelled")
      },
      "helpers.user.roles" => {
        "worker" => I18n.t("helpers.user.roles.worker"),
        "customer" => I18n.t("helpers.user.roles.customer")
      }
    }

    translations.dig("helpers.#{enum_name}", enum_key.to_s) || enum_key.to_s.humanize
  end
end
