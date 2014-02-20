if Rails.env.production?
  Community::Application.config.middleware.use ExceptionNotifier,
    :email_prefix => "[Community] ",
    :sender_address => %{""Exception Notifier" <gregory@practicingruby.com>},
    :exception_recipients => %w{gregory.t.brown@gmail.com jordan.byron@gmail.com}
end
