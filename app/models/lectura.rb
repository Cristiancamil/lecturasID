class Lectura < ApplicationRecord
    belongs_to :device

    validates :lectura_actual, presence: true
end
