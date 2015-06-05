class Textquestion < ActiveRecord::Base
	has_many :textresponses
	belongs_to :audience
	validates :question, presence: true, length: { maximum: 140 }
	obfuscate_id :spin => 4203133769

	public

	  def as_json(options={})
	    super(include: [:audience])
	  end
end
