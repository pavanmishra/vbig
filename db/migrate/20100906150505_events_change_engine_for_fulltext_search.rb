class EventsChangeEngineForFulltextSearch < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE  events engine = MYISAM"
    execute "ALTER TABLE events ADD FULLTEXT(title)"
  end

  def self.down
    execute 'DROP INDEX title ON events'
    execute "ALTER TABLE events engine = InnoDB"
  end
end
