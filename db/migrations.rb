require 'active_record'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'notes.db'
)

class NotesSetup < ActiveRecord::Migration
  def setup
    create_table :notes do |t|
      t.string :code
      t.string :title
      t.string :body
      t.date :created_at
      t.boolean :visible
    end
  end
end

begin
  NotesSetup.new.setup
rescue ActiveRecord::StatementInvalid
  puts "table already exists"
end