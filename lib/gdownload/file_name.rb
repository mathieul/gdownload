module FileName
  def unique_name_for(name)
    while existing = Dir[name].sort.last
      name, ext = split_name_extension(existing)
      name = unique_name(name)
      name = [name, ext].join(".")
    end
    name
  end

  private

  def split_name_extension(name)
    tokens = name.split(".")
    ext = tokens.pop if tokens.length > 1
    name = tokens.join(".")
    [name, ext]
  end

  def unique_name(name)
    if name.match(/^(.*)-(\d+)$/)
      num = $2
      "#{$1}-#{num.to_i + 1}"
    else
      "#{name}-1"
    end
  end
end
