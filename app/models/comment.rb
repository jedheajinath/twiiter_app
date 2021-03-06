class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :parent, class_name: :Comment, foreign_key: :parent_id
  has_many :parents, class_name: :Comment, foreign_key: :parent_id, dependent: :destroy

  validates :message, presence: true 

  def ancestors(hash = {})
    hash[self.id] = self
    self.parents.each do |child|
      hash[child.id] = child
      if child.parents.present?
        child.ancestors
      end
    end
    return hash
  end

  # def ancestors(hash={})
  #   self.parents.each do |child|
  #      hash[child.id] = child.message
  #     if child.parents.present?
  #        hash[child.id] = {}
  #        child.ancestors(hash[child.id])
  #     end
  #   end
  #   return hash
  # end

  def get_root_comment
    if self.parent.present?
      self.parent.get_root_comment
    else
      return self.post
    end
  end

end
