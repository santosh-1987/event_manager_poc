class EventsController < ApplicationController
  def index
  end

  # /events/export
  # Exports Data in CSV & JSON Format
  def export
    Api::Iterable::Export.data
  end

  # /events/notify
  # Sends a Email notification through Iterable API
  def notify
    Api::Iterable::Notify.send_email
  end


end
