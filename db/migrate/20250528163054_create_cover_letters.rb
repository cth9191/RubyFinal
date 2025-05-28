class CreateCoverLetters < ActiveRecord::Migration[7.1]
  def change
    create_table :cover_letters do |t|
      t.string :user_name
      t.string :company_name
      t.string :role
      t.text :extra_info
      t.text :generated_letter

      t.timestamps
    end
  end
end
