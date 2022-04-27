# frozen_string_literal: true

class Merchant < ActiveRecord::Base
	validates_presence_of :name, :email, :cif
    validates :name, uniqueness: true
    validates :email, uniqueness: true
end
    