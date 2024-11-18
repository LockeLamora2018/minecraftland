class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table "articles", force: :cascade do |t|
      t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    end
  end
end
