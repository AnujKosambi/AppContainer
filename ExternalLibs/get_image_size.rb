
class GetImageSize

  def self.GetDimensions(url)
    size = IO.read(url)[0x10..0x18].unpack('NN')
    size
  end

end