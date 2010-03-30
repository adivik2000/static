class Page < ActiveRecord::Base

  attr_accessible :title, :body

  before_validation :generate_slug

  validates_presence_of :title, :body, :slug
  validates_uniqueness_of :title, :slug

  def generate_slug
    self.slug = to_param rescue nil
  end

  def self.home
    find_by_slug!('home')
  rescue ActiveRecord::RecordNotFound
    Page.create!(:title => 'Home', :body => '<p>Welcome to Static. Visit <a href="/admin">/admin</a> to get started.</p>')
  end

  def home?
    slug == 'home'
  end

  def to_s
    title
  end

  def to_param
   to_s.parameterize
  end
end