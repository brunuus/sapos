# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class CourseType < ActiveRecord::Base
  has_many :courses

  has_paper_trail

  validates :name, :presence => true, :uniqueness => true

  def to_label
  	"#{self.name}"
  end
end
