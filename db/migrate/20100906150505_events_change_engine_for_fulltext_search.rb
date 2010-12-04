class EventsChangeEngineForFulltextSearch < ActiveRecord::Migration
  def self.up
    case ActiveRecord::Base.connection.adapter_name
    when 'MySQL'
      execute "ALTER TABLE  events engine = MYISAM"
      execute "ALTER TABLE events ADD FULLTEXT(title)"
    end
  end

  def self.down
    case ActiveRecord::Base.connection.adapter_name
    when 'MySQL'
      execute 'DROP INDEX title ON events'
      execute "ALTER TABLE events engine = InnoDB"
    end
  end
end
