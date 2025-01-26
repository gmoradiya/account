Rails.application.config.active_storage.paths = {
  pdf: lambda { |record|
    "#{record.patient.id}/#{record.id}/pdf/#{SecureRandom.hex(10)}.pdf"
  }
}