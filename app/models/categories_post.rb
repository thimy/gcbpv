# == Schema Information
#
# Table name: categories_posts
#
#  id          :bigint           not null, primary key
#  category_id :bigint
#  post_id     :bigint
#
# Indexes
#
#  index_categories_posts_on_category_id  (category_id)
#  index_categories_posts_on_post_id      (post_id)
#
class CategoriesPost < ApplicationRecord
  belongs_to :category
  belongs_to :post

  validates :category, presence: true
  validates :post, presence: true
end
