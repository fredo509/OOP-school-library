require 'json'
module Store
  def self.save(file_path, data)
    arr = JSON.pretty_generate(data)
    File.write(file_path, arr.to_s)
  end

  def self.read_data_from_file(file_path)
    data = File.read(file_path)
    data.empty? ? [] : JSON.parse(data)
  end
end
