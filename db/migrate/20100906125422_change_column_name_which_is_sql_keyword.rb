class ChangeColumnNameWhichIsSqlKeyword < ActiveRecord::Migration
  def self.up
    rename_column :events, :from, :from_date
  end

  def self.down
    rename_column :events, :from_date, :from
  end
end
