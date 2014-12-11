class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string  :to
      t.string  :to_name
      t.string  :from
      t.string  :from_name
      t.string  :subject
      t.string  :body
      t.boolean :delivered, :default => false
    end
  end

  def self.down
    drop_table :messages
  end
end
