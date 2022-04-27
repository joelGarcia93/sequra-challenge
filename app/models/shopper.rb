# frozen_string_literal: true

class Shopper < ActiveRecord::Base
	validates_presence_of :name, :email, :nif
    validates :email, uniqueness: true
end
    