class LoggingAction

  # around_action時に呼び出される(before,after両方)
  def around(controller)
    controller.logger.debug "#{Time.now} before: #{controller.action_name}"
    yield
    controller.logger.debug "#{Time.now} after: #{controller.action_name}"
  end
end