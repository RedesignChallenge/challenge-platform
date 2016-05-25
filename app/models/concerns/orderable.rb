module Orderable
  extend ActiveSupport::Concern

  included do
    default_scope { 
      order(featured: :desc, comments_count: :desc, created_at: :desc, id: :desc) 
    }
  end
  
end
