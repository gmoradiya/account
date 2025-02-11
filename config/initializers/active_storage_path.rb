# config/initializers/active_storage_path.rb

Rails.application.config.after_initialize do
  ActiveStorage::Blob.class_eval do
    def key
      # Access associated record details via the attachment
      attachment = attachments.first # Access the first attachment associated with the blob

      if attachment&.record
        model = attachment.record.class.name.underscore.pluralize
        record_id = attachment.record.id
        # if attachment.record.class == FollowUp
        #   "patients/#{attachment.record.patient_id}/#{model}/#{record_id}/#{filename.sanitized}"
        # else
          "#{model}/#{record_id}/#{filename.sanitized}"
        # end
      else
        super # Fallback to default behavior if no associated record is found
      end
    end
  end
end
