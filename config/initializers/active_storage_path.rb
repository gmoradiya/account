Rails.application.config.after_initialize do
  ActiveStorage::Blob.class_eval do
    def key
      # Define the custom directory structure: model_name/id/filename
      model = record_type.underscore.pluralize
      "#{model}/#{record_id}/#{filename.sanitized}"
    end
  end
end
