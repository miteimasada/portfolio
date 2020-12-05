class AddStepToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :step1, :text
    add_column :posts, :step2, :text
    add_column :posts, :step3, :text
  end
end
