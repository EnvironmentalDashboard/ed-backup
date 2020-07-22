# https://raw.githubusercontent.com/omardelarosa/ruby-file-tree/master/tree.rb
require 'json'

class FileTree

  attr_accessor :hash

  def initialize(path)
    @hash = make_hash(path)
  end

  def to_json
    @hash.to_json
  end

  def to_html(hash = @hash)
    html = ""
    if hash
      hash.each do |key, val|
        html << "<li>" \
          << "<a href='#{val['full_path'].sub('./public', '')}'>" \
            << key \
          << "</a>" \
          << "</li>"
          
        if val["children"]
          html << "<ul>"
          html << self.to_html(val["children"])
          html << "</ul>"
        end
      end
    end
    html
  end

  def to_s
    @hash.to_s
  end

  def to_h
    @hash
  end

  private

  def make_hash(path)
    hash = {}

    return hash unless Dir.exist? path

    Dir.entries(path).select { |file|
      !['.', '..'].include? file
    }.each do |file|
      full_path = File.join(path, file)
      if File.directory? full_path
        hash[file] = {
          "children" => make_hash(full_path),
          "type" => 'directory',
          "full_path" => full_path
        }
      else
        hash[file] = {
          "children" => nil,
          "type" => 'file',
          "full_path" => full_path
        }
      end
    end
    hash
  end

end
