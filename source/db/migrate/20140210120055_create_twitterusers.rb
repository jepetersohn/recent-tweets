class CreateTwitterusers < ActiveRecord::Migration
  def change
    create_table :twitterusers do |t|
      t.string :handle
    end
  end
end
