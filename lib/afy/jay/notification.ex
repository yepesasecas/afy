defmodule Afy.Jay.Notification do
  alias Afy.Jay.Notification

  def topic do
    "com.limonadademango.jay"
  end

  def push(user, %{"alert" => alert, "badge" => badge, "sound" => sound, "category" => category, "custom" => custom}) do
    Pigeon.APNS.Notification.new(alert, user.device_token, Notification.topic())
    |> Pigeon.APNS.Notification.put_badge(badge)
    |> Pigeon.APNS.Notification.put_sound(sound)
    |> Pigeon.APNS.Notification.put_category(category)
    |> Pigeon.APNS.Notification.put_custom(custom)
    # |> Pigeon.APNS.Notification.put_content_available()
    # |> Pigeon.APNS.Notification.put_mutable_content()
    |> Pigeon.APNS.push
    |> Map.delete(:device_token)
    |> Map.delete(:topic)
  end
end
