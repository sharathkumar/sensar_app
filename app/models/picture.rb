class Picture < ActiveRecord::Base

	has_attached_file :picture, 	
		path: ":rails_root/public/system/:class/:attachement/:id/:basename_:style.:extension",
    url: "/system/:class/:attachement/:id/:basename_:style.:extension",
    styles: { preview: "600>", medium: "300x300>", thumb: "100x100>" }

  validates_attachment :picture,
    presence: true,
    size: { in: 0..10.megabytes },
    content_type: { content_type: /\Aimage\/.*\Z/ }

  def decode_image(string_base64)
    StringIO.open(Base64.decode64(string_base64)) do |data|
      data.original_filename = "image_name.jpg"
      data.content_type = "image/jpeg"
      self.picture = data
    end
	end

end
