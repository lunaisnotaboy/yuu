ActionMailer::DeliveryJob.class_eval do
  queue_as :soon
end
