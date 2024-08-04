Rails.application.config.to_prepare do
    ActiveStorage::Attachment.class_eval do
      def self.ransackable_attributes(auth_object = nil)
        %w[blob_id created_at id name record_id record_type]
      end
  
      def self.ransackable_associations(auth_object = nil)
        %w[blob record]
      end
    end
  
    ActiveStorage::Blob.class_eval do
      def self.ransackable_attributes(auth_object = nil)
        %w[content_type created_at filename id key metadata service_name]
      end
    end
  end
  