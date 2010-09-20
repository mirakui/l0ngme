class Entry
  include MongoMapper::Document

  key :source_url, String
  key :long_url, String
  key :user_id, String
  key :created_at, Time
end
