require "test_helper"

require "active_record"
require "blog/app/models/application_record"
require "blog/app/models/post"

class ActiveRecordTest < Minitest::Test
  def setup
    Post.establish_connection(
      database: "#{__dir__}/blog/db/development.sqlite3"
    )
  end

  def test_initialize
    post = Post.new(id: 1, title: "title", body: "body")

    assert_equal post.id, 1
    assert_equal post.title, "title"
    assert_equal post.body, "body"
  end

  def test_find
    post = Post.find(1)

    assert_kind_of Post, post
    assert_equal post.id, 1
    assert_equal post.title, "Post A"
    assert_equal post.body, "Body a....."
  end

  def test_all
    posts = Post.all

    assert_kind_of ActiveRecord::Relation, posts

    post = posts.first
    assert_equal post.id, 1
    assert_equal post.title, "Post A"
    assert_equal post.body, "Body a....."
  end

  def test_execute
    rows = Post.connection.execute("SELECT * FROM posts")
    assert_kind_of Array, rows

    row = rows.first
    assert_kind_of Hash, row
    assert_equal [:id, :title, :body, :created_at, :updated_at], row.keys
  end

  def test_where
    relation = Post.where("id = 1").where("title IS NOT NULL")
    assert_equal "SELECT * FROM posts WHERE id = 1 AND title IS NOT NULL",
      relation.to_sql

    post = relation.first
    assert_equal post.id, 1
    assert_equal post.title, "Post A"
    assert_equal post.body, "Body a....."
  end

  def test_order
    relation = Post.order("created_at DESC").order("id")
    assert_equal "SELECT * FROM posts ORDER BY created_at DESC, id", relation.to_sql
  end

end
